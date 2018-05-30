# == Type: cron::job
#
# This type creates a cron job in $::cron::dot_dir
#
# === Parameters
#
# [*command*]
#   The command to execute
#
# [*ensure*]
#   The state of the resource, valid values are 'present', 'absent'. Default is
#   'present'.
#
# [*environment*]
#   An array of environment variables. Defaults to an empty array.
#
# [*comment*]
#   A comment to be added to the cronjob file describing the job.
#
# [*user*]
#   The user the cron job should be execute as. Defauls to 'root'.
#
# [*minute*]
#   The minute the cron job should run, 0-59. Defaults to '*'.
#
# [*hour*]
#   The hour the cron job should run, 0-23. Defaults to '*'.
#
# [*day*]
#   The day of month the cron job should run, 1-31. Defaults to '*'.
#
# [*month*]
#   The month the cron job should run, 1-12. Defaults to '*'.
#
# [*weekday*]
#   The day of week the cron job should run, 0-7. (0 or 7 is Sunday). Defaults
#   to '*'.
#
# === Sample Usage
#
# cron::job { 'who_is_logged_in':
#   command     => 'who',
#   environment => [ 'MAILTO=admin@example.com' ],
#   minute      => '7',
# }
#
define cron::job (
  String $command,
  Enum['present', 'absent'] $ensure = 'present',
  Array[String] $environment        = [],
  String $comment                   = '',
  String $user                      = 'root',
  String $minute                    = '*',
  String $hour                      = '*',
  String $day                       = '*',
  String $month                     = '*',
  String $weekday                   = '*',
) {
  include cron

  file { "${::cron::dot_dir}/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('cron/job.erb')
  }
}
