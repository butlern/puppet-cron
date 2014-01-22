require 'spec_helper'

describe 'cron', :type => :class do
  # Default facts used for contexts
  let(:facts) {{
    :osfamily => 'Debian'
  }}

  describe 'cron::install class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_package('cron') }
  end

  context 'with no parameters' do
    it { should contain_package('cron') }
  end

  context 'with parameters' do
    let(:params) {{
      :package_name => 'cronie',
      :package_ensure => '1.2.3',
    }}

    it { should contain_package('cronie').with({
      'ensure' => '1.2.3'
      })
    }
  end
end
