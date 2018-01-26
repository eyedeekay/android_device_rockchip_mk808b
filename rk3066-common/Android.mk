LOCAL_PATH := $(call my-dir)

LOCAL_OVERRIDES_PACKAGES := CMUpdater

ifneq ($(filter mk808,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
