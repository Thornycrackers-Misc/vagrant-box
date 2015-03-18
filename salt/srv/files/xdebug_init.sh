#!/bin/bash
#
# THIS FILE IS MANAGED BY SALT. ANY CHANGES MADE HERE WILL BE REVERTED IF VAGRANT'S PROVISIONING IS CHANGED.
# PLEASE ADD ANY PERMANENT CHANGES TO THE CORRESPONDING FILE IN THE ONE OF THE PUPPET MODULES.
#

> /etc/php5/mods-available/xdebug.ini
echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/mods-available/xdebug.ini
echo '; Added to enable Xdebug ;' >> /etc/php5/mods-available/xdebug.ini
echo ';;;;;;;;;;;;;;;;;;;;;;;;;;' >> /etc/php5/mods-available/xdebug.ini
echo '' >> /etc/php5/mods-available/xdebug.ini
echo 'zend_extension="'$(find / -name 'xdebug.so' 2> /dev/null)'"' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.default_enable = 1' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_enable = 1' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_autostart = 1' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_port = 9000' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_handler=dbgp' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_log="/var/log/xdebug/xdebug.log"' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_host=10.0.2.2 ; IDE-Environments IP, from vagrant box.' >> /etc/php5/mods-available/xdebug.ini
