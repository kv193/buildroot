#############################################################
#
# pcmciautils
#
#############################################################
PCMCIAUTILS_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/pcmciautils/pcmciautils-015
PCMCIAUTILS_SITE_METHOD = svn
PCMCIAUTILS_VERSION = 694

PCMCIAUTILS_DEPENDENCIES = libsysfs

define PCMCIAUTILS_BUILD_CMDS
	$(MAKE1) -C $(@D) OPTIMIZATION="$(TARGET_CFLAGS)" CROSS="$(TARGET_CROSS)"
endef

define PCMCIAUTILS_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define PCMCIAUTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/pccardctl $(TARGET_DIR)/sbin/
	ln -s $(TARGET_DIR)/sbin/pccardctl $(TARGET_DIR)/sbin/lspcmcia
endef

define PCMCIAUTILS_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/sbin/pccardctl
	rm -f $(TARGET_DIR)/sbin/lspcmcia
endef

$(eval $(generic-package))
