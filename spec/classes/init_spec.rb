require 'spec_helper'

describe 'cron' do
  context 'supported operating systems' do
    describe "cron class without any parameters on Debian" do
      let(:params) {{ }}
      let(:facts) {{
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '14.04',
      }}

      it { should contain_class('cron::params') }

      it { should contain_class('cron::install') }
      it { should contain_class('cron::config') }
      it { should contain_class('cron::service') }
    end
  end

  context 'unsupported operating system' do
    describe 'cron class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
        :operatingsystemrelease => '7',
      }}

      it { expect { should raise_error(Puppet::Error, /Nexenta not supported/) }}
    end
  end
end
