# cron

Puppet module for cron.

[![Build Status](https://travis-ci.org/butlern/puppet-cron.png)](https://travis-ci.org/butlern/puppet-cron)

## Example usage

Include with default parameters:
```puppet
include cron
```

Include with the singleton pattern:
```puppet
class { '::cron': }
```

Log both start and end of cronjobs
```puppet
class { '::cron':
  extra_opts => '-L 2'
}
```

### Cron Jobs

Cronjobs are placed in /etc/cron.d. If you want cronjobs to be removed
automatically when they are removed from a manifest, instead of having
to 'ensure => absent', specify purge_dot_d => true when instantiating
the cron class

```puppet
class { '::cron':
  purge_dot_dir => true,
}
```

*Please note that this is destructive to existing unmanaged cronjobs in
/etc/cron.d! See Below.*

Example cronjob
```puppet
cron::job { 'disk usage':
  command => 'df -h',
  minute => '0',
  hour => '2',
  environment => [ 'MAILTO=admin@example.com' ]
  comment => "Send disk usage stats every hour"
}
```

### Purging /etc/cron.d

If you enable purging of files in /etc/cron.d but you don't want puppet to
purge cronjobs installed by packages. It is enough that somewhere in your
manifest, you specify a file resource for the cronjob in question and ensure
that it's present. You don't need to specify any other parameters to the
file resource, nor do you need to manage its content.

Example:

```puppet
include foo

# Ensure foo's cronjob isn't purged
file { "${::cron::dot_dir}/foojob" :
  ensure => 'present',
}
```

## License

See [LICENSE](LICENSE) file.
