# == Class: cron
#
# Full description of class cron here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it default to.
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
  validate_bool($lsbnames)
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
