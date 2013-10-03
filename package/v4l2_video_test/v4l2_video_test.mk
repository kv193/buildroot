#############################################################
#
# V4L2 video test application
#
#############################################################
V4L2_VIDEO_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/v4l2_video_test
V4L2_VIDEO_TEST_SITE_METHOD = svn
V4L2_VIDEO_TEST_VERSION = 526

define V4L2_VIDEO_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define V4L2_VIDEO_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/v4l2_video_capture $(TARGET_DIR)/bin/
	$(INSTALL) -D -m 0755 $(@D)/v4l2_video_display $(TARGET_DIR)/bin/
	$(INSTALL) -D -m 0755 $(@D)/v4l2_video_loopback $(TARGET_DIR)/bin/
endef

define V4L2_VIDEO_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define V4L2_VIDEO_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/v4l2_video_capture
	rm -f $(TARGET_DIR)/bin/v4l2_video_display
	rm -f $(TARGET_DIR)/bin/v4l2_video_loopback
endef

$(eval $(generic-package))
