#############################################################
#
# video test application
#
#############################################################
VIDEO_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/video_test
VIDEO_TEST_SITE_METHOD = svn
VIDEO_TEST_VERSION = 526

define VIDEO_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define VIDEO_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/video_test $(TARGET_DIR)/bin/
endef

define VIDEO_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define VIDEO_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/video_test
endef

$(eval $(generic-package))
