#############################################################
#
# cpufreq utils
#
#############################################################
CPUFREQUTILS_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/cpufrequtils
CPUFREQUTILS_SITE_METHOD = svn
CPUFREQUTILS_VERSION = 696

define CPUFREQUTILS_BUILD_CMDS
	$(MAKE) -C $(@D)/cpufrequtils-005 \
	V=true \
	NLS=false \
	CROSS=$(CROSS_COMPILE) \
	DESTDIR=$(STAGING_DIR) \
	$(TARGET_CONFIGURE_OPTS)
endef

define CPUFREQUTILS_INSTALL_TARGET_CMDS
	if ! [ -d "$(TARGET_DIR)/bin/" ]; then \
		mkdir -p $(TARGET_DIR)/bin/; \
	fi
	$(MAKE) -C $(@D)/cpufrequtils-005 \
	V=true \
	NLS=false \
	CROSS=$(CROSS_COMPILE) \
	DESTDIR=$(TARGET_DIR) install
endef

define CPUFREQUTILS_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define CPUFREQUTILS_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/cpufreq*
	rm -f $(TARGET_DIR)/usr/lib/libcpufreq.so.*
endef

$(eval $(generic-package))
