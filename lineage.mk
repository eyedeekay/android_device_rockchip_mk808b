# Release name
PRODUCT_RELEASE_NAME := MK808B

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/rockchip/mk808b/full_mk808b.mk)

PRODUCT_RESTRICT_VENDOR_FILES := false

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := mk808b
PRODUCT_NAME := lineage_mk808b
PRODUCT_BRAND := Rockchip
PRODUCT_MODEL := MK808B
PRODUCT_MANUFACTURER := Rockchip

#TARGET_DEVICE := mk808b
#TARGET_NAME := lineage_mk808b
