#############################################################
#
# bfin crc test
#
#############################################################
CRC_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/crc_test
CRC_TEST_SITE_METHOD = svn
CRC_TEST_VERSION = 526

define CRC_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define CRC_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/bfin_crc_test $(TARGET_DIR)/bin/
endef

define CRC_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define CRC_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/bfin_crc_test
endef

$(eval $(generic-package))
