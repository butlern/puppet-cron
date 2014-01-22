require 'spec_helper'

describe 'cron', :type => :class do
  # Default facts used for contexts
  let(:facts) {{
    :osfamily => 'Debian'
  }}

  describe 'cron::config class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_file('/etc/init/cron.override') }
    it { should contain_file('/etc/cron.d') }
    it { should contain_file('/etc/cron.d/.placeholder') }
  end

  context 'with no parameters' do
    let(:params) {{ }}

    it { should contain_file('/etc/init/cron.override').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      }) \
      .with_content(/exec cron -L 1/)
    }

    it { should contain_file('/etc/cron.d').with({
      'ensure' => 'directory',
      'recurse' => true,
      'purge' => false,
      })
    }

    it { should contain_file('/etc/cron.d/.placeholder').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      })
    }
  end

  context 'with parameters' do
    let(:params) {{
      :dot_dir => '/var/cron.d',
      :purge_dot_dir => true,
      :lsbnames => true,
      :extra_opts => 'foo'
    }}

    it { should contain_file('/etc/init/cron.override').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      }) \
      .with_content(/exec cron -l foo/)
    }

    it { should contain_file('/var/cron.d').with({
      'ensure' => 'directory',
      'recurse' => true,
      'purge' => true,
      })
    }

    it { should contain_file('/var/cron.d/.placeholder').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      })
    }
  end
end
