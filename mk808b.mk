
# include common makefile
$(call inherit-product, device/rockchip/rk3066-common/common.mk)

LOCAL_PATH := device/rockchip/mk808b

# Overlay
#DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_AAPT_configs := ldpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := ldpi

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.rk30board:root/fstab.rk30board \
    $(LOCAL_PATH)/init.rk30board.rc:root/init.rk30board.rc

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.otg=slave \
    persist.sys.usb.config=mtp

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=wifi-only \
    ro.sf.lcd_density=160 \
    ro.config.facelock=enable_facelock \
    persist.facelock.detect_cutoff=5000 \
    persist.facelock.recog_cutoff=5000

$(call inherit-product-if-exists, vendor/rockchip/mk808b/mk808b-vendor.mk)
