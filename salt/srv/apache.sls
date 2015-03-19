apache:
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
      - pkg: apache

/var/www:
  file.absent

symlink-folders:
  file.symlink:
    - name: '/var/www'
    - target: '/vagrant'

/etc/apache2/apache2.conf:
  file.managed:
    - source: 'salt://files/apache2.conf'

/etc/apache2/sites-enabled/000-default.conf:
  file.managed:
    - source: 'salt://files/default.conf'

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2
