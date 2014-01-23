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
  $package_name = hiera('cron::package_name', $cron::params::package_name),
  $package_ensure = hiera('cron::package_ensure',
                          $cron::params::package_ensure),
  $service_name = hiera('cron::service_name', $cron::params::service_name),
  $service_ensure = hiera('cron::service_ensure',
                          $cron::params::service_ensure),
  $service_manage = hiera('cron::service_manage',
                          $cron::params::service_manage),
  $dot_dir = hiera('cron::dot_dir', $cron::params::dot_dir),
  $purge_dot_dir = hiera('cron::purge_dot_dir', $cron::params::purge_dot_dir),
  $override_file = hiera('cron::override_file', $cron::params::override_file),
  $lsbnames = hiera('cron::lsbnames', $cron::params::lsbnames),
  $extra_opts = hiera('cron::extra_opts', $cron::params::extra_opts),
) inherits cron::params {

  # validate parameters here
  validate_bool($service_manage, $purge_dot_dir, $lsbnames)
  validate_string($extra_opts)

  anchor { 'cron::begin': } ->
  class { 'cron::install': } ->
  class { 'cron::config': }
  class { 'cron::service': } ->
  anchor { 'cron::end': }

  Anchor['cron::begin']  ~> Class['cron::service']
  Class['cron::install'] ~> Class['cron::service']
  Class['cron::config']  ~> Class['cron::service']
}
