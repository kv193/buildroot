#############################################################
#
# play and tone applications
#
#############################################################
PLAY_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/play
PLAY_SITE_METHOD = svn
PLAY_VERSION = 693

define PLAY_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define PLAY_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/play $(TARGET_DIR)/bin/
	$(INSTALL) -D -m 0755 $(@D)/tone $(TARGET_DIR)/bin/
endef

define PLAY_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define PLAY_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/play
	rm -f $(TARGET_DIR)/bin/tone
endef

$(eval $(generic-package))
