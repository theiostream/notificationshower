THEOS_DEVICE_IP=192.168.1.105

include theos/makefiles/common.mk

TWEAK_NAME = NotificationShower
NotificationShower_FILES = NotificationShowerController.m
NotificationShower_INSTALL_PATH = /System/Library/WeeAppPlugins/NotificationShower.bundle/
NotificationShower_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)cp -r Resources/* $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/NotificationShower.bundle/$(ECHO_END)
	$(ECHO_NOTHING)mv $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/NotificationShower.bundle/NotificationShower.dylib $(THEOS_STAGING_DIR)/System/Library/WeeAppPlugins/NotificationShower.bundle/NotificationShower$(ECHO_END)

