#############################################################
#
# bfin ppifcd-cgi
#
#############################################################
PPIFCD_CGI_SITE = http://svn.code.sf.net/p/adi-openapp/code/trunk/apps/ppifcd-cgi
PPIFCD_CGI_SITE_METHOD = svn
PPIFCD_CGI_VERSION = 576

define PPIFCD_CGI_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src
endef

define PPIFCD_CGI_INSTALL_TARGET_CMDS
if ! [ -d $(TARGET_DIR)/home ]; then \
	mkdir -p $(TARGET_DIR)/home; \
fi
cp -rdpf $(@D)/web $(TARGET_DIR)/home/httpd
$(INSTALL) -m 0755 -D $(@D)/src/fcd.cgi  $(TARGET_DIR)/home/httpd/cgi-bin/fcd.cgi
ln -sf -s index.htm $(TARGET_DIR)/home/httpd/index.html
endef

define PPIFCD_CGI_CLEAN_CMDS
	$(MAKE) -C $(@D) clean
endef

define PPIFCD_CGI_UNINSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/home/httpd
endef

$(eval $(generic-package))
