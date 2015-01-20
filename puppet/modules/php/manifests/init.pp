class php {
  package { ['php5',
             'php5-cli',
             'libapache2-mod-php5',
             'php-apc',
             'php5-curl',
             'php5-dev',
             'php5-gd',
             'php5-imagick',
             'php5-intl',
             'php5-mcrypt',
             'php5-memcache',
             'php5-mongo',
             'php5-mysql',
             'php5-pspell',
             'php5-sqlite',
             'php5-tidy',
             'php5-xdebug',
             'php5-xmlrpc',
             'php5-xsl']:
    ensure => present,
    require => Class["apache"];
  }


  file {

    '/etc/apache2/mods-enabled/dir.conf':
      path => '/etc/apache2/mods-enabled/dir.conf',
      ensure => file,
      source => 'puppet:///modules/php/dir.conf',
      require => Package['php5'];

    '/etc/php5/apache2':
      ensure => directory,
      before => File ['/etc/php5/apache2/php.ini'],
      require => Package['php5'];
    
    '/etc/php5/apache2/php.ini':
      source  => 'puppet:///modules/php/apache2-php.ini',
      require => Package['php5'];
    
    '/etc/php5/cli/php.ini':
      source  => 'puppet:///modules/php/cli-php.ini',
      require => Package['php5-cli'];

    '/var/log/php-errors.log':
      ensure => present,
      path => '/var/log/php-errors.log',
      owner => 'www-data',
      group => 'www-data',
      require => Package['php5'];

    '/tmp/xdebug_init.sh':
      ensure => present,
      path => '/tmp/xdebug_init.sh',
      owner => 'root',
      group => 'root',
      mode => '0755',
      source  => 'puppet:///modules/php/xdebug_init.sh',
      notify => Exec['xdebug_init.sh'],
      require => Package['php5-xdebug'];

  }

  # Restart Apache after updating dir.conf
  exec { 
    'apache2 restart':
      command => 'service apache2 restart',
      require => File['/etc/apache2/mods-enabled/dir.conf'];

    'xdebug_init.sh':
      command => '/tmp/xdebug_init.sh',
      require => Package['php5-xdebug'];

    'composer install':
      command => 'curl -sS http://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
      onlyif => 'test ! -f /usr/local/bin/composer',
      require => Package['php5'];

    'symfony install':
      command => 'curl -LsS http://symfony.com/installer > symfony.phar && sudo mv symfony.phar /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony',
      onlyif => 'test ! /usr/local/bin/symfony',
      require => Package['php5'];
  }

}
