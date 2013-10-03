#############################################################
#
# fixed_code test
#
#############################################################
FIXED_CODE_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/fixed_code_test
FIXED_CODE_TEST_SITE_METHOD = svn
FIXED_CODE_TEST_VERSION = 526

define FIXED_CODE_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define FIXED_CODE_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/fixed_code $(TARGET_DIR)/bin/
	$(INSTALL) -D -m 0755 $(@D)/fixed_code_p $(TARGET_DIR)/bin/
endef

define FIXED_CODE_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define FIXED_CODE_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/fixed_code
	rm -f $(TARGET_DIR)/bin/fixed_code_p
endef

$(eval $(generic-package))
