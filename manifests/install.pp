# == Class cron::install
#
class cron::install {

  package { $::cron::package_name:
    ensure => $::cron::package_ensure,
  }
}
