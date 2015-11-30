LIBRARY_NAME = libproxychains4 proxychains_loader
TOOL_NAME = proxychains4

libproxychains4_FILES = proxychains/src/libproxychains.c proxychains/src/allocator_thread.c proxychains/src/common.c proxychains/src/core.c proxychains/src/debug.c proxychains/src/hash.c proxychains/src/hostsreader.c proxychains/src/ip_type.c proxychains/src/nameinfo.c proxychains/src/version.c
proxychains4_FILES = proxychains/src/main.c proxychains/src/common.c
proxychains_loader_FILES = loader.c
proxychains_loader_LIBRARIES = substrate

export TARGET = iphone:clang
export ARCHS = armv7 armv7s arm64
export TARGET_IPHONEOS_DEPLOYMENT_VERSION = 3.0
export TARGET_IPHONEOS_DEPLOYMENT_VERSION_armv7s = 6.0
export TARGET_IPHONEOS_DEPLOYMENT_VERSION_arm64 = 7.0
export ADDITIONAL_CFLAGS = -D_GNU_SOURCE -DSUPER_SECURE -DIS_MAC=1 -Ds6_addr16=__u6_addr.__u6_addr16 -Ds6_addr32=__u6_addr.__u6_addr32 -DLIB_DIR=\"/usr/lib\" -DSYSCONFDIR=\"/etc\" -DDLL_NAME=\"libproxychains4.dylib\"
export GO_EASY_ON_ME = 1

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/tool.mk

before-all::
	$(ECHO_NOTHING)make -C proxychains src/version.h$(ECHO_END)

internal-stage::
	$(ECHO_NOTHING)etc="$(THEOS_STAGING_DIR)/etc"; mkdir -p "$$etc"; cp proxychains/src/proxychains.conf "$$etc"$(ECHO_END)
