# == Class cron::service
#
# This class is meant to be called from cron
# It ensure the service is running
#
class cron::service {

  if ($::cron::service_manage) {
    service { $::cron::service_name:
      ensure     => $::cron::service_ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
