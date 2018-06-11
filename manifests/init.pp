# == Class: cron
#
# The cron class manages the cron package, service and configuration.
#
# === Parameters
#
# [*package_name*]
#   The name of the package. Default is 'cron'.
#
# [*package_ensure*]
#   The state of the package, 'absent', 'installed'. Can also specify the
#   package version, e.g. '1.2.3-1' to pin a version. Default is 'present'.
#
# [*service_name*]
#   The name of the cron service. Default is 'cron'.
#
# [*service_ensure*]
#   Whether the service is 'running' or 'stopped'. Default is 'running'.
#
# [*service_manage*]
#   Boolean. Whether to manage the service or not. Default is true.
#
# [*dot_dir*]
#   The cron.d directory path. For placing crontab files for cron::job.
#
# [*purge_dot_dir*]
#   Boolean. Whether we purge unmanaged crontab files in cron.d. Useful if you
#   want to convenience of not having to 'ensure => absent' on cron::job
#   resources before removing them from your manifests. With this enabled, you
#   can just remove them from your manifest and they will be automatically
#   purged from the cron.d directory. DANGER! This will purged ALL unmanaged
#   cronjob entries in cron.d, even ones installed outside of puppet by
#   packages. BEWARE. Default is false.
#
# [*init_type*]
#   Enum. Either upstart or systemd. Used to determine how to properly override
#   the cron extra_opts.
#
# [*override_file*]
#   The path to the cron upstart service override file. Default to
#   '/etc/init/cron.override'.
#
# [*lsbnames*]
#   Boolean. Whether to enable LSB compliant names for cron.d files.
#
# [*extra_opts*]
#   Extra cron options. For more info see cron(8). Default is '-L 1'.
#
class cron (
  String $package_name = $cron::params::package_name,
  String $package_ensure = $cron::params::package_ensure,
  String $service_name = $cron::params::service_name,
  String $service_ensure = $cron::params::service_ensure,
  Boolean $service_manage = $cron::params::service_manage,
  String $dot_dir = $cron::params::dot_dir,
  Boolean $purge_dot_dir = $cron::params::purge_dot_dir,
  String $override_file = $cron::params::override_file,
  String $init_type = $cron::params::init_type,
  Boolean $lsbnames = $cron::params::lsbnames,
  String $extra_opts = $cron::params::extra_opts,
) inherits cron::params {

  class { 'cron::install': } ->
  class { 'cron::config': } ->
  class { 'cron::service': }

  contain 'cron::install'
  contain 'cron::config'
  contain 'cron::service'
}
