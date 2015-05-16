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


/etc/apache2/mods-enabled/dir.conf:
  file.managed:
    - source: 'salt://files/dir.conf'

/etc/php5/apache2:
  file.directory:
    - makedirs: True

/etc/php5/apache2/php.ini:
  file.managed:
    - source: 'salt://files/php.ini'

/etc/php5/cli:
  file.directory:
    - makedirs: True

/etc/php5/cli/php.ini:
  file.managed:
    - source: 'salt://files/php-cli.ini'

/var/log/php-errors.log:
  file.managed:
    - user: www-data
    - owner: www-data

/tmp/xdebug_init.sh:
  file.managed:
    - owner: root
    - group: root
    - mode: 0755
    - source: 'salt://files/xdebug_init.sh'

xdebug-script:
  cmd.run:
    - name: /tmp/xdebug_init.sh

install-composer:
  cmd.run:
    - unless: which composer
    - name: curl -sS http://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer

install-symfony:
  cmd.run:
    - unless: which symfony
    - name: curl -LsS http://symfony.com/installer > symfony.phar && sudo mv symfony.phar /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony

install-phpunit:
  cmd.run:
    - unless: which phpunit
    - name: wget https://phar.phpunit.de/phpunit.phar && sudo mv phpunit.phar /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

install-phpcpd:
  cmd.run:
    - unless: which phpcpd
    - name: wget https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd
    
php-apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2
