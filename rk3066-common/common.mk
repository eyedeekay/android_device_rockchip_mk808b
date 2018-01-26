#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

COMMON_PATH := device/rk3066-common

DEVICE_PACKAGE_OVERLAYS := $(COMMON_PATH)/overlay

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/init.rk30board.usb.rc:root/init.rk30board.usb.rc \
    device/rockchip/rk3066-common/ueventd.rk30board.rc:root/ueventd.rk30board.rc

# Firmware
PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/prebuilt/firmware/athtcmd_ram.bin:system/etc/firmware/athtcmd_ram.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/athwlan.bin.z77:system/etc/firmware/athwlan.bin.z77 \
    device/rockchip/rk3066-common/prebuilt/firmware/bdata.SD31.bin:system/etc/firmware/bdata.SD31.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/data.patch.hw2_0.bin:system/etc/firmware/data.patch.hw2_0.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/device.bin:system/etc/firmware/device.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4319.bin:system/etc/firmware/fw_bcm4319.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4329_wapi.bin:system/etc/firmware/fw_bcm4329_wapi.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4330_apsta.bin:system/etc/firmware/fw_bcm4330_apsta.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_bcm4330.bin:system/etc/firmware/fw_bcm4330.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901a0_apsta.bin:system/etc/firmware/fw_RK901a0_apsta.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901a0.bin:system/etc/firmware/fw_RK901a0.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901a2_apsta.bin:system/etc/firmware/fw_RK901a2_apsta.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901a2.bin:system/etc/firmware/fw_RK901a2.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901a2_p2p.bin:system/etc/firmware/fw_RK901a2_p2p.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK901.bin:system/etc/firmware/fw_RK901.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK903b2_apsta.bin:system/etc/firmware/fw_RK903b2_apsta.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK903b2.bin:system/etc/firmware/fw_RK903b2.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK903b2_p2p.bin:system/etc/firmware/fw_RK903b2_p2p.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK903.bin:system/etc/firmware/fw_RK903.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/fw_RK903_p2p.bin:system/etc/firmware/fw_RK903_p2p.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_4330.txt:system/etc/firmware/nvram_4330.txt \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_B23.txt:system/etc/firmware/nvram_B23.txt \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_RK901.bad:system/etc/firmware/nvram_RK901.bad \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_RK901.txt:system/etc/firmware/nvram_RK901.txt \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_RK903_26M.cal:system/etc/firmware/nvram_RK903_26M.cal \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_RK903.cal:system/etc/firmware/nvram_RK903.cal \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram_RK903.txt:system/etc/firmware/nvram_RK903.txt \
    device/rockchip/rk3066-common/prebuilt/firmware/nvram.txt:system/etc/firmware/nvram.txt \
    device/rockchip/rk3066-common/prebuilt/firmware/otp.bin.z77:system/etc/firmware/otp.bin.z77 \
    device/rockchip/rk3066-common/prebuilt/firmware/sd8686.bin:system/etc/firmware/sd8686.bin \
    device/rockchip/rk3066-common/prebuilt/firmware/sd8686_helper.bin:system/etc/firmware/sd8686_helper.bin

# Hardware-specific features
PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/configs/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    device/rockchip/rk3066-common/configs/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    device/rockchip/rk3066-common/configs/permissions/android.software.pppoe.xml:system/etc/permissions/android.software.pppoe.xml \
    device/rockchip/rk3066-common/configs/permissions/features.xml:system/etc/permissions/features.xml \
    device/rockchip/rk3066-common/configs/permissions/platform.xml:system/etc/permissions/platform.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    device/rockchip/rk3066-common/configs/permissions/com.android.location.provider.xml:system/etc/permissions/com.android.location.provider.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    device/rockchip/rk3066-common/configs/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    device/rockchip/rk3066-common/configs/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    device/rockchip/rk3066-common/configs/permissions/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml

# WiFi
PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Vold/Storage
PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/configs/vold.fstab:system/etc/vold.fstab

# Audio/Alsa
PRODUCT_COPY_FILES += \
    device/rockchip/rk3066-common/configs/asound.conf:system/etc/asound.conf \
    device/rockchip/rk3066-common/configs/audio_policy.conf:system/etc/audio_policy.conf \
    device/rockchip/rk3066-common/configs/media_codecs.xml:system/etc/media_codecs.xml \
    device/rockchip/rk3066-common/configs/media_profiles.xml:system/etc/media_profiles.xml \
    device/rockchip/rk3066-common/configs/alsa/alsa.conf:system/usr/share/alsa/alsa.conf \
    device/rockchip/rk3066-common/configs/alsa/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
    device/rockchip/rk3066-common/configs/alsa/init/00main:system/usr/share/alsa/init/00main \
    device/rockchip/rk3066-common/configs/alsa/init/default:system/usr/share/alsa/init/default \
    device/rockchip/rk3066-common/configs/alsa/init/hda:system/usr/share/alsa/init/hda \
    device/rockchip/rk3066-common/configs/alsa/init/help:system/usr/share/alsa/init/help \
    device/rockchip/rk3066-common/configs/alsa/init/info:system/usr/share/alsa/init/info \
    device/rockchip/rk3066-common/configs/alsa/init/test:system/usr/share/alsa/init/test \
    device/rockchip/rk3066-common/configs/alsa/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
    device/rockchip/rk3066-common/configs/alsa/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf

# Build extra packages

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    tinyplay

# Bluetooth
PRODUCT_PACKAGES += \
    hciconfig \
    hcitool \
    bttest \
    l2ping

# Filesystem management
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Rockchip utils
PRODUCT_PACKAGES += \
    rk_afptool \
    rk_img_unpack \
    rk_img_maker \
    rk_mkkrnlimg \
    rk_mkbootimg

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Graphics
PRODUCT_PACKAGES += \
    librs_jni

# Extra packages
PRODUCT_PACKAGES += \
    Camera

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    ro.opengles.version=131072 \
    hwui.render_dirty_regions=false \
    wifi.supplicant_scan_interval=15

ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.timezone=Europe/Stockholm \
    ro.allow.mock.location=1 \
    ro.kernel.android.checkjni=1 \
    sys.hwc.compose_policy=6 \
    testing.mediascanner.skiplist=/mnt/sdcard/Android/

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_TAGS += dalvik.gc.type-precise

# Inherit tablet dalvik settings
$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

# Include google apps
$(call inherit-product-if-exists, vendor/google/gapps.mk)

# Setup proprietary files
$(call inherit-product-if-exists, vendor/rockchip/rk3066-common/common-vendor.mk)
