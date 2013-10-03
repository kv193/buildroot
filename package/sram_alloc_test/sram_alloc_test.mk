#############################################################
#
# sram_alloc test
#
#############################################################
SRAM_ALLOC_TEST_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/sram-alloc-test
SRAM_ALLOC_TEST_SITE_METHOD = svn
SRAM_ALLOC_TEST_VERSION = 526

define SRAM_ALLOC_TEST_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define SRAM_ALLOC_TEST_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/sram_alloc $(TARGET_DIR)/bin/
endef

define SRAM_ALLOC_TEST_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define SRAM_ALLOC_TEST_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/sram_alloc
endef

$(eval $(generic-package))
