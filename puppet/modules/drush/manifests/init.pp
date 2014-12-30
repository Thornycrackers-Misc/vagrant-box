class drush {
  package { ['drush']:
    ensure => present,
    require => Class['php'];
  }
}
