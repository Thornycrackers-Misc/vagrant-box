# Module for install node and using nvm on the server
class nodejs {
  package { "nodejs-legacy":
    ensure => present,
    require => Class["system-update"];
  }

  package { 'npm':
    ensure => present,
    require => Package['nodejs-legacy'],
  }

  exec { 'install-foundation-cli':
    command => 'npm install -g foundation-cli',
    require => Package['npm'],
  }

  exec { 'install-bower':
    command => 'npm install -g bower',
    require => Package['npm'],
  }

  exec { 'install-gulp':
    command => 'npm install -g gulp',
    require => Package['npm'],
  }

  exec { 'install-cordova':
    command => 'npm install -g cordova',
    require => Package['npm'],
  }

  exec { 'install-ionic':
    command => 'npm install -g ionic',
    require => Package['npm'],
  }

  exec { 'install-grunt':
    command => 'npm install -g grunt',
    require => Package['npm'],
  }
}
