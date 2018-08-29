ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222

TWEAK_NAME = riftboard
riftboard_FILES = Tweak.xm SBTest.xm CKBlurView.m SBTestActivatorEventShow.m SBTestActivatorEventDismiss.m RBPrefs.m
riftboard_FRAMEWORKS = UIKit Foundation QuartzCore CoreGraphics
riftboard_LIBRARIES = activator substrate
riftboard_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

riftboard_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

TARGET := iphone:8.0:8.0

include $(THEOS_MAKE_PATH)/tweak.mk

include $(THEOS)/makefiles/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
