require 'spec_helper'

describe 'cron' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "cron class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should contain_class('cron::params') }

        it { should contain_class('cron::install') }
        it { should contain_class('cron::config') }
        it { should contain_class('cron::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'cron class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
