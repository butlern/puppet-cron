# == Class cron::params
#
# This class is meant to be called from cron
# It sets variables according to platform
#
class cron::params {
  case $osfamily {
    'Debian': {
      $package_name = 'cron'
      $package_ensure = 'present'
      $service_name = 'cron'
      $service_ensure = 'running'
      $service_manage = true
      $dot_dir = '/etc/cron.d'
      $purge_dot_dir = false
      $lsbnames = false
      $extra_opts = '-L 1'

      if ($operatingsystem == 'Ubuntu' and versioncmp($operatingsystemrelease, '16.04') < 0) or ($operatingsystem == 'Debian' and versioncmp($operatingsystemrelease, '9') < 0) {
        $init_type = 'upstart'
        $override_file = '/etc/init/cron.override'
      } else {
        $init_type = 'systemd'
        $override_file = '/etc/systemd/system/cron.service.d/override.conf'
      }
    }
    default: {
      fail("${operatingsystem} not supported")
    }
  }
}
