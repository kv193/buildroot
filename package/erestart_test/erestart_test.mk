#############################################################
#
# erestart test
#
#############################################################
ERESTART_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/erestart_test
ERESTART_TEST_SITE_METHOD = svn
ERESTART_TEST_VERSION = 526


define ERESTART_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define ERESTART_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/erestart $(TARGET_DIR)/bin/
endef

define ERESTART_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define ERESTART_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/erestart
endef

$(eval $(generic-package))
