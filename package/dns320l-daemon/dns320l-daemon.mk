################################################################################
#
# dns320l-daemon
#
################################################################################

DNS320L_DAEMON_VERSION = 1.0
DNS320L_DAEMON_SOURCE = tip.tar.bz2
DNS320L_DAEMON_SITE = https://www.aboehler.at/hg/dns320l-daemon/archive
DNS320L_DAEMON_LICENSE = GPL-3
DNS320L_DAEMON_DEPENDENCIES = iniparser


define DNS320L_DAEMON_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE"
endef

define DNS320L_DAEMON_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dns320l-daemon $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0600 $(@D)/dns320l-daemon.ini $(TARGET_DIR)/etc/
endef

define DNS320L_DAEMON_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/dns320l-daemon.service $(TARGET_DIR)/lib/systemd/system/
endef

define DNS320L_DAEMON_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_DLINK_DNS320L_PATH)/package/dns320l-daemon/S50dns320l-daemon $(TARGET_DIR)/etc/init.d/S50dns320l-daemon
endef

$(eval $(generic-package))

