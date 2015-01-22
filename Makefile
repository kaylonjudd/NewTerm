TARGET = iphone:clang:latest:7.0

include theos/makefiles/common.mk

GLOBAL_CFLAGS = -include NewTerm/NewTerm-Prefix.pch -Iheaders

LIBRARY_NAME = libvt100
libvt100_FILES = $(wildcard VT100/*.m)
libvt100_FRAMEWORKS = CoreGraphics CoreText QuartzCore UIKit
libvt100_CFLAGS = $(GLOBAL_CFLAGS)
libvt100_LIBRARIES = curses
libvt100_INSTALL_PATH = /Applications/NewTerm.app

APPLICATION_NAME = NewTerm
NewTerm_FILES = $(wildcard NewTerm/*.m) $(wildcard NewTerm/SubProcess/*.m)
NewTerm_FRAMEWORKS = UIKit CoreGraphics
NewTerm_CFLAGS = $(GLOBAL_CFLAGS) -fobjc-arc
NewTerm_LDFLAGS = -Lobj
NewTerm_LIBRARIES = vt100

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall NewTerm; sleep 0.2; sblaunch ws.hbang.Terminal" || true