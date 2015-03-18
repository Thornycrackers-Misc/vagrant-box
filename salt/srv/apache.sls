install-apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - enable: True

a2enmod rewrite:
  cmd.run:
    - unless: 'ls /etc/apache2/mods-enabled/rewrite.load'
    - order: 225
    - require:
      - pkg: install-apache

remove-html-folder:
  file.absent:
    - name: '/var/www'

symlink-vagrant:
  file.symlink:
    - name: '/var/www'
    - target: '/vagrant'

apache2-conf-file:
  file.managed:
    - name: '/etc/apache2/apache2.conf'
    - source: 'salt://files/apache2.conf'

default-conf-file:
  file.managed:
    - name: '/etc/apache2/sites-enabled/000-default.conf'
    - source: 'salt://files/default.conf'

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2
