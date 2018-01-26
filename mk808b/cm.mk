# Release name
PRODUCT_RELEASE_NAME := MK808

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/rockchip/mk808bb/full_mk808bb.mk)

PRODUCT_RESTRICT_VENDOR_FILES := false

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := mk808bb
PRODUCT_NAME := cm_mk808bb
PRODUCT_BRAND := Rockchip
PRODUCT_MODEL := MK808
PRODUCT_MANUFACTURER := Rockchip
