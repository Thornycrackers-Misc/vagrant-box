php-packages:
  pkg.installed:
    - pkgs:
      - php5
      - php5-cli
      - libapache2-mod-php5
      - php-apc
      - php5-curl
      - php5-dev
      - php5-gd
      - php5-imagick
      - php5-intl
      - php5-mcrypt
      - php5-memcache
      - php5-mssql
      - php5-mongo
      - php5-mysql
      - php5-pspell
      - php5-sqlite
      - php5-sybase
      - php5-tidy
      - php5-xdebug
      - php5-xmlrpc
      - php5-xsl
      - pdftk


apache-dir-conf:
  file.managed:
    - name: '/etc/apache2/mods-enabled/dir.conf'
    - source: 'salt://files/dir.conf'

php-ini-directory:
  file.directory:
    - name: '/etc/php5/apache2'
    - makedirs: True

php-ini:
  file.managed:
    - name: '/etc/php5/apache2/php.ini'
    - source: 'salt://files/php.ini'

php-cli-ini-directory:
  file.directory:
    - name: '/etc/php5/cli'
    - makedirs: True

php-cli-ini:
  file.managed:
    - name: '/etc/php5/cli/php.ini'
    - source: 'salt://files/php-cli.ini'

php-error-log:
  file.managed:
    - name: '/var/log/php-errors.log'
    - user: www-data
    - owner: www-data

xdebug-init-script:
  file.managed:
    - name: '/tmp/xdebug_init.sh'
    - owner: root
    - group: root
    - mode: 0755
    - source: 'salt://files/xdebug_init.sh'

run-xdebug-script:
  cmd.run:
    - name: /tmp/xdebug_init.sh

install-composer:
  cmd.run:
    - name: curl -sS http://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer

install-symfony:
  cmd.run:
    - name: curl -LsS http://symfony.com/installer > symfony.phar && sudo mv symfony.phar /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony

php-apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2
