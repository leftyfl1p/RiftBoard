include $(THEOS)/makefiles/common.mk
#rename bundle
BUNDLE_NAME = RiftBoard
RiftBoard_FILES = RBRootListController.m RiftBoardBlurListController.m RBPreviewCell.m RiftBoardSupportListController.m RBTranslationsListController.m

RiftBoard_INSTALL_PATH = /Library/PreferenceBundles
RiftBoard_FRAMEWORKS = UIKit QuartzCore Accelerate
RiftBoard_PRIVATE_FRAMEWORKS = Preferences AppSupport
RiftBoard_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/RiftBoard.plist$(ECHO_END)
