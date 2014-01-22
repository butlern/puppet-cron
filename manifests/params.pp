# == Class cron::params
#
# This class is meant to be called from cron
# It sets variables according to platform
#
class cron::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'cron'
      $package_ensure = 'present'
      $service_name = 'cron'
      $service_ensure = 'running'
      $service_manage = true
      $dot_dir = '/etc/cron.d'
      $purge_dot_dir = false
      $override_file = '/etc/init/cron.override'
      $lsbnames = false
      $extra_opts = '-L 1'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
