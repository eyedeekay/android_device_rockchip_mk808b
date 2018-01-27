
# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk

include device/rockchip/rk3066-common/BoardCommonConfig.mk

USE_CAMERA_STUB := false

PRODUCT_MODEL := Rockchip MK808B
PRODUCT_MANUFACTURER := Rockchip

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00800000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00004000@0x00004000(kernel),0x00008000@0x00008000(boot),0x00008000@0x00010000(recovery),0x000C0000@0x00018000(backup),0x00040000@0x000D8000(cache),0x00002000@0x00118000(kpanic),0x00100000@0x0011A000(system),-@0x0021A000(userdata) bootver=2012-08-29#1.16 firmware_ver=4.0.4
TARGET_CPU_VARIANT=cortex-a9
TARGET_KERNEL_CONFIG := rk3066_mk808b_defconfig

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 419430400
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912
BOARD_FLASH_BLOCK_SIZE := 16384

#NUM_FRAMEBUFFER_SURFACE_BUFFERS :=
