# == Class cron::config
#
# This class is called from cron
#
class cron::config {

  File {
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  $lsbnames = $::cron::lsbnames
  $extra_opts = $::cron::extra_opts

  file { $::cron::override_file:
    content => template('cron/upstart/override.erb')
  }

  file { $::cron::dot_dir:
    ensure  => directory,
    recurse => true,
    purge   => $::cron::purge_dot_dir,
  }

  file { "${::cron::dot_dir}/.placeholder":
    content => '# DO NOT EDIT OR REMOVE
This file is a simple placeholder to keep dpkg from removing this directory
',
  }

  # Resource ordering
  File[$::cron::dot_dir] -> File["${::cron::dot_dir}/.placeholder"]
}
