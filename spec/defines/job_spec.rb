require 'spec_helper'

describe 'cron::job', :type => :define do
  let(:title) do
    'foo'
  end

  let(:facts) {{
    :osfamily => 'Debian',
    :operatingsystem => 'Ubuntu',
    :operatingsystemrelease => '14.04',
  }}

  context 'when installing a cronjob' do
    let(:params) {{
      :command => 'who',
    }}

    it { should contain_file('/etc/cron.d/foo') \
         .with_content(/\* \* \* \* \* root who/) \
         .without_content(/# Environment/) \
         .without_content(/^# /)
    }
  end

  context 'when installing a cronjob with custom parameters' do
    let(:params) {{
      :command => 'tail -n 10 /var/log/syslog',
      :environment => [ 'MAILTO=admin@example.com' ],
      :user => 'bob',
      :comment => 'Get the last 10 lines of syslog',
      :minute => '1',
      :hour => '1',
      :day => '1',
      :month => '1',
      :weekday => '1',
    }}

    it { should contain_file('/etc/cron.d/foo') \
         .with_content(/# Environment/) \
         .with_content(/MAILTO=admin@example.com/) \
         .with_content(/# Get the last 10 lines of syslog/) \
         .with_content(%r{1 1 1 1 1 bob tail -n 10 /var/log/syslog})
    }
  end

  context 'when installing a cronjob with no parameters' do
    let(:params) {{ }}
    it { should raise_error(Puppet::ParseError) }
  end

  context 'when installing a cronjob with invalid ensure' do
    let(:params) {{
      :command => 'echo foo',
      :ensure  => 'disabled',
    }}
    it { should raise_error(Puppet::ParseError) }
  end
end
