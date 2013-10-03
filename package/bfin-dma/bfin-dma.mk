#############################################################
#
# bfin dma test
#
#############################################################
BFIN_DMA_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/tests/bfin-dma
BFIN_DMA_SITE_METHOD = svn
BFIN_DMA_VERSION = 526

define BFIN_DMA_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define BFIN_DMA_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(INSTALL) -D -m 0755 $(@D)/bfin-dma $(TARGET_DIR)/bin/
endef

define BFIN_DMA_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define BFIN_DMA_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/bfin-dma
endef

$(eval $(generic-package))
