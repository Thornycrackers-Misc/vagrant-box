# Installs some bundles using Ubuntu default ruby
class ruby {
  package { 'ruby-full':
    ensure => present,
    require => Class["system-update"];
  }

  exec { 'install-bundler':
    command => 'gem install bundler',
    require => Package['ruby-full'],
  }

  exec { 'install-sass':
    command => 'gem install sass',
    require => Package['ruby-full'],
  }
}
