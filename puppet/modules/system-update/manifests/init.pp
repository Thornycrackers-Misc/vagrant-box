class system-update {
  exec { 
    'apt-get update':
      command => 'apt-get update',
  }

  $sysPackages = [ "build-essential" ]

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
}
