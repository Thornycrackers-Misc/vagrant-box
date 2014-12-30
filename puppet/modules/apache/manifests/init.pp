# Creates apache with a www dir set to /vagrant

class apache {
  package { "apache2":
    ensure => present,
    require => Class["system-update"],
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  file { 

    '/var/www/html/index.html':
      ensure => absent,
      require => Package["apache2"];

    '/var/www/html':
      ensure => absent,
      require => File['/var/www/html/index.html'];

    "/var/www":
      ensure => 'link',
      target => '/vagrant',
      force => true,
      require => File["/var/www/html"];

    "/etc/apache2/apache2.conf":
      source => 'puppet:///modules/apache/apache2.conf',
      require => Package['apache2'],
      notify => Service['apache2'];

    "/etc/apache2/sites-enabled/000-default.conf":
      source => 'puppet:///modules/apache/default.conf',
      require => Package['apache2'],
      notify => Service['apache2'];

  }

  exec {
    'sudo a2enmod rewrite':
      command => 'sudo a2enmod rewrite',
      require => Package["apache2"];

    'sudo service apache2 restart':
      command => 'sudo service apache2 restart',
      require => Exec['sudo a2enmod rewrite'];
  }
}
