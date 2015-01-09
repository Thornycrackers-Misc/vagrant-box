class system-update {
  exec { 
    'apt-get update':
      command => 'apt-get update',
  }

  # Install some things for mail to work 
  $sysPackages = [ "build-essential", "mailutils", "sendmail" ]

  package { $sysPackages:
    ensure => "installed",
    require => Exec['apt-get update'],
  }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode => '0644',
      source => 'puppet:///modules/system-update/bashrc';

    '/home/vagrant/.vimrc':
      ensure => present,
      owner => 'vagrant',
      group => 'vagrant',
      mode => '0644',
      source => 'puppet:///modules/system-update/vimrc';
  }

  host {
    'email faster':
      ensure => present,
      name => 'localhost.localdomain',
      host_aliases => [ 'localhost', 'vagrant-ubuntu-trusty-32' ],
      ip => '127.0.0.1';
  }
}
