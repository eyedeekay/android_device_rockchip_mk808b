/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "bluedroid"

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <cutils/log.h>
#include <cutils/properties.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

#include <bluedroid/bluetooth.h>

#ifndef HCI_DEV_ID
#define HCI_DEV_ID 0
#endif

#define HCID_STOP_DELAY_USEC 500000

#define MIN(x,y) (((x)<(y))?(x):(y))


static const char *ignore = "rfkill0";  //ignore rfkill0 on mk808, it's not an actual bluetooth device
static const char *sysrfkill = "/sys/class/rfkill";
static char rfkill_state_path[64] = "";


static int init_rfkill() {
    char path[64];
    char buf[16];
    int fd;
    int sz;
    struct dirent *entry;
    DIR *sysdir = opendir(sysrfkill);

    if (sysdir == NULL) {
        ALOGE("opendir failed: %s (%d)\n", strerror(errno), errno);
        return -1;
    }

    while ((entry = readdir(sysdir))) {
    if (entry->d_name[0] == '.' || strstr(entry->d_name, ignore))
            continue;
        snprintf(path, sizeof(path), "%s/%s/type", sysrfkill, entry->d_name);
        fd = open(path, O_RDONLY);
        if (fd < 0) {
            ALOGW("open(%s) failed: %s (%d)\n", path, strerror(errno), errno);
            continue;
        }
        sz = read(fd, &buf, sizeof(buf));
        close(fd);
        if (sz >= 9 && memcmp(buf, "bluetooth", 9) == 0) {
            snprintf(rfkill_state_path, sizeof(rfkill_state_path),
                    "%s/%s/state", sysrfkill, entry->d_name);
            break;
        }
    }

    closedir(sysdir);
    return rfkill_state_path[0] ? 0 : -1;
}

static int check_bluetooth_power() {
    int fd = -1;
    int ret = -1;
    char buffer;

    if (rfkill_state_path[0] == '\0') {
        if (init_rfkill()) goto out;
    }

    fd = open(rfkill_state_path, O_RDONLY);
    if (fd < 0) {
        ALOGE("open(%s) failed: %s (%d)", rfkill_state_path, strerror(errno),
             errno);
        goto out;
    }
    if (read(fd, &buffer, 1) != 1) {
        ALOGE("read(%s) failed: %s (%d)", rfkill_state_path, strerror(errno),
             errno);
        goto out;
    }

    switch (buffer) {
    case '1':
        ret = 1;
        break;
    case '0':
        ret = 0;
        break;
    }

out:
    if (fd >= 0) close(fd);
    return ret;
}

static int set_bluetooth_power(int on) {
    int fd = -1;
    int ret = check_bluetooth_power();
    const char buffer = (on ? '1' : '0');

    if (ret < 0)
        return ret;
    else if (ret == on)
        return 0;

    fd = open(rfkill_state_path, O_WRONLY);
    if (fd < 0) {
        ALOGE("open(%s) for write failed: %s (%d)", rfkill_state_path,
             strerror(errno), errno);
        goto out;
    }
    if (write(fd, &buffer, 1) != 1) {
        ALOGE("write(%s) failed: %s (%d)", rfkill_state_path, strerror(errno),
             errno);
        goto out;
    }
    ret = 0;

out:
    if (fd >= 0) close(fd);
    return ret;
}

static int create_hci_sock() {
    int sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
    if (sk < 0) {
        ALOGE("Failed to create bluetooth hci socket: %s (%d)",
             strerror(errno), errno);
    }
    return sk;
}

int bt_enable() {
    ALOGV(__FUNCTION__);

    int ret = -1;
    int hci_sock = -1;
    int attempt;

    // Try for 10 seconds, this can only succeed once hciattach has sent the
    // firmware and then turned on hci device via HCIUARTSETPROTO ioctl
    for (attempt = 100; attempt > 0; --attempt) {
        int res = set_bluetooth_power(1);
        usleep(900000);
        if (res < 0) {
            bt_disable();
            continue;
        }
        hci_sock = create_hci_sock();
        if (hci_sock < 0) goto out;

        ret = ioctl(hci_sock, HCIDEVUP, HCI_DEV_ID);

        if (!ret) {
            break;
        } else if (errno == EALREADY) {
            ALOGW("Bluetoothd already started, unexpectedly!");
            break;
        }

        ALOGI("%s: ioctl(%d, HCIDEVUP, HCI_DEV_ID) failed: %s (%d)",
              __FUNCTION__, hci_sock, strerror(errno), errno);

        close(hci_sock);
        usleep(100 * 1000);  // 100 ms retry delay
    }
    if (attempt == 0) {
        ALOGE("%s: Timeout waiting for HCI device to come up, error- %d, ",
            __FUNCTION__, ret);
        set_bluetooth_power(0);
        goto out;
    }

    ALOGI("Starting bluetoothd deamon");
    if (property_set("ctl.start", "bluetoothd") < 0) {
        ALOGE("Failed to start bluetoothd");
        set_bluetooth_power(0);
        goto out;
    }
    sleep(2);

    ret = 0;

out:
    if (hci_sock >= 0) close(hci_sock);
    return ret;
}

int bt_disable() {
    ALOGV(__FUNCTION__);

    int ret = -1;
    int hci_sock = -1;

    ALOGI("Stopping bluetoothd deamon");
    if (property_set("ctl.stop", "bluetoothd") < 0) {
        ALOGE("Error stopping bluetoothd");
        goto out;
    }
    usleep(HCID_STOP_DELAY_USEC);

    hci_sock = create_hci_sock();
    if (hci_sock < 0) goto out;
    ioctl(hci_sock, HCIDEVDOWN, HCI_DEV_ID);

    if (set_bluetooth_power(0) < 0) {
        goto out;
    }
    ret = 0;

out:
    rfkill_state_path[0] = '\0';

    if (hci_sock >= 0) close(hci_sock);
    return ret;
}

int bt_is_enabled() {
    ALOGV(__FUNCTION__);

    int hci_sock = -1;
    int ret = -1;
    struct hci_dev_info dev_info;


    // Check power first
    ret = check_bluetooth_power();
    if (ret == -1 || ret == 0) goto out;

    ret = -1;

    // Power is on, now check if the HCI interface is up
    hci_sock = create_hci_sock();
    if (hci_sock < 0) goto out;

    dev_info.dev_id = HCI_DEV_ID;
    if (ioctl(hci_sock, HCIGETDEVINFO, (void *)&dev_info) < 0) {
        ret = 0;
        goto out;
    }

    if (dev_info.flags & (1 << (HCI_UP & 31))) {
        ret = 1;
    } else {
        ret = 0;
    }

out:
    if (hci_sock >= 0) close(hci_sock);
    return ret;
}

int ba2str(const bdaddr_t *ba, char *str) {
    return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
                ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
}

int str2ba(const char *str, bdaddr_t *ba) {
    int i;
    for (i = 5; i >= 0; i--) {
        ba->b[i] = (uint8_t) strtoul(str, (char **) &str, 16);
        str++;
    }
    return 0;
}
