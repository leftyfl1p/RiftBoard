ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

#THEOS_DEVICE_IP = 10.0.1.183

TWEAK_NAME = sbtest
sbtest_FILES = Tweak.xm SBTest.xm CKBlurView.x SBTestActivatorEventShow.x SBTestActivatorEventDismiss.x
sbtest_FRAMEWORKS = UIKit Foundation QuartzCore CoreGraphics
sbtest_LIBRARIES = activator substrate
sbtest_CFLAGS = -fobjc-arc
#sbtest_LDFLAGS += -Wl,-segalign,4000

#sbtest_LIBRARIES = 

TARGET := iphone:8.0:8.0

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = sbtestBundle

sbtestBundle_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
