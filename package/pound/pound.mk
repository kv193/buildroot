#############################################################
#
# pound
#
#############################################################

POUND_SITE:=http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/pound
POUND_SITE_METHOD = svn
POUND_VERSION = 558
POUND_DEPENDENCIES = openssl

#define POUND_CONFIGURE_CMDS
#	$(CONFIG_UPDATE) $(@D)
#	sed -i 's/CFLAGS=/CFLAGS+=/g' $(@D)/Makefile
#	sed -i '/cd .*doc/d' $(@D)/Makefile
#	sed -i '/include/d' $(@D)/Makefile
#	touch $@
#endef
#F_CONF="pound.cfg"
VERSION=2.0
POUND_CFLAGS = $(TARGET_CFLAGS) -I$(LINUX_SRCDIR)/include -I$(LINUX_SRCDIR)/arch/blackfin/include -DHAVE_SYSLOG_H=1 -DVERSION=$(VERSION) -pthread -DNEED_STACK -DEMBED -D__uClinux__  -D_REENTRANT -D_THREAD_SAFE

define POUND_BUILD_CMDS
	$(MAKE) CFLAGS="$(POUND_CFLAGS)"  OS=$(ARCH) CC="$(TARGET_CC)" -C $(@D)
endef

define POUND_INSTALL_TARGET_CMDS
        cp -a $(@D)/pound $(TARGET_DIR)/bin/pound
	test -d $(TARGET_DIR)/etc/pound || mkdir $(TARGET_DIR)/etc/pound
	cp $(@D)/mycert.pem $(TARGET_DIR)/etc/pound
	test -d $(TARGET_DIR)/usr/local	|| (mkdir -p $(TARGET_DIR)/usr/local/etc)
	cp $(@D)/pound.cfg $(TARGET_DIR)/usr/local/etc
	test -d $(TARGET_DIR)/home/httpd || (mkdir -p $(TARGET_DIR)/home/httpd)
	cp $(@D)/index.html $(TARGET_DIR)/home/httpd

endef

define POUND_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

$(eval $(autotools-package))

