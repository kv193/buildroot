#############################################################
#
# twi_keypad test
#
#############################################################
TWI_KEYPAD_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/twi_keypad-test
TWI_KEYPAD_TEST_SITE_METHOD = svn
TWI_KEYPAD_TEST_VERSION = 526


define TWI_KEYPAD_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define TWI_KEYPAD_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/twikeypad_test $(TARGET_DIR)/bin/
endef

define TWI_KEYPAD_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define TWI_KEYPAD_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/twi_keypad
endef

$(eval $(generic-package))
