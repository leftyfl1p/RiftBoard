include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = riftboard
riftboard_FILES = RBRootListController.m
riftboard_INSTALL_PATH = /Library/PreferenceBundles
riftboard_FRAMEWORKS = UIKit
riftboard_PRIVATE_FRAMEWORKS = Preferences
riftboard_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/riftboard.plist$(ECHO_END)
