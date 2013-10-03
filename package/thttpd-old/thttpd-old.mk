#############################################################
#
# thttpd old
#
#############################################################

THTTPD_OLD_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/ndso/thttpd
THTTPD_OLD_SITE_METHOD = svn
THTTPD_OLD_VERSION = 526

THTTPD_OLD_MAKE_CFLAGS = $(TARGET_CFLAGS) -DHAVE_FCNTL_H=1 -DEMBED=1 -DHAVE_MEMORY_H=1 \
        -DHAVE_PATHS_H=1 -DTIME_WITH_SYS_TIME=1 -DHAVE_DIRENT_H=1 \
	        -DHAVE_LIBCRYPT=1 -DHAVE_STRERROR=1 -DHAVE_WAITPID=1 \
		        -DHAVE_UNISTD_H=1 -DHAVE_GETPAGESIZE=1 -O2


define THTTPD_OLD_BUILD_CMDS
        $(MAKE) -C $(@D) CC="$(TARGET_CC)" CFLAGS="$(THTTPD_OLD_MAKE_CFLAGS)"
endef

define THTTPD_OLD_CLEAN_CMDS
        $(MAKE) -C $(@D) clean
endef

define THTTPD_OLD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/thttpd $(TARGET_DIR)/sbin/
endef

define THTTPD_OLD_UNINSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/sbin/thttpd
endef




$(eval $(generic-package))
