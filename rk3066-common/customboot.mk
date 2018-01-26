RK_UPDATE_PATH := $(PRODUCT_OUT)/rkupdate
INSTALLED_BOOTIMAGE_TARGET := $(RK_UPDATE_PATH)/boot.img
INSTALLED_RECOVERYIMAGE_TARGET := $(RK_UPDATE_PATH)/recovery.img
MKKRNLIMG := $(HOST_OUT_EXECUTABLES)/rk_mkkrnlimg

$(INSTALLED_BOOTIMAGE_TARGET) : $(MKKRNLIMG) $(INSTALLED_RAMDISK_TARGET)
	$(call pretty,"Target boot image: $@")
	mkdir -p $(RK_UPDATE_PATH)
	$(hide) $(MKKRNLIMG) -a $(INSTALLED_RAMDISK_TARGET) $@
$(INSTALLED_RECOVERYIMAGE_TARGET) : $(MKKRNLIMG) $(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	mkdir -p $(RK_UPDATE_PATH)
	$(hide) $(MKKRNLIMG) -a $(recovery_ramdisk) $@

$(RK_UPDATE_PATH)/system.img: $(RK_UPDATE_PATH)/system.img $(FULL_SYSTEMIMAGE_DEPS) $(INSTALLED_FILES_FILE)
	@echo -e ${CL_CYN}"----- Making rk_system image ------"${CL_RST}
	$(HOST_OUT_EXECUTABLES)/simg2img $(BUILT_SYSTEMIMAGE) $@
$(RK_UPDATE_PATH)/update.img: $(INSTALLED_BOOTIMAGE_TARGET) $(INSTALLED_RECOVERYIMAGE_TARGET) $(RK_UPDATE_PATH)/system.img
	cp device/rockchip/rk3066-common/package/* $(RK_UPDATE_PATH)
	cd $(RK_UPDATE_PATH) && $(HOST_OUT_EXECUTABLES)/rk_afptool -pack $(RK_UPDATE_PATH) update.img
$(RK_UPDATE_PATH)/flash.img: $(RK_UPDATE_PATH)/update.img
	cd $(RK_UPDATE_PATH) && $(HOST_OUT_EXECUTABLES)/rk_img_maker "RK30xxLoader(L)_V1.16.bin" update.img flash.img
$(RK_UPDATE_PATH)/kernel.img: $(PRODUCT_OUT)/kernel
	@echo -e ${CL_CYN}"----- Making kernel ------"${CL_RST}
	$(MKKRNLIMG) -a $(PRODUCT_OUT)/kernel $@
.PHONY: rk_systemimage rk_updateimage rk_flashimage rk_kernelimage rk_clean
rk_systemimage: $(RK_UPDATE_PATH)/system.img

rk_updateimage: $(RK_UPDATE_PATH)/update.img

rk_flashimage: $(RK_UPDATE_PATH)/flash.img

rk_kernelimage: $(RK_UPDATE_PATH)/kernel.img
rk_clean:
	rm $(RK_UPDATE_PATH) -rf
