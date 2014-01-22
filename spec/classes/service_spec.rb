require 'spec_helper'

describe 'cron', :type => :class do
  # Default facts used for contexts
  let(:facts) {{
    :osfamily => 'Debian'
  }}

  context 'with no parameters' do
    it { should contain_service('cron') }
  end

  context 'with different service name' do
    let(:params) {{
      :service_name => 'cronie',
    }}

    it { should contain_service('cronie') }
  end

  context 'with service stopped' do
    let(:params) {{
      :service_ensure => 'stopped',
    }}

    it { should contain_service('cron').with({
      :ensure => 'stopped',
      })
    }
  end

  context 'with service unmanaged' do
    let(:params) {{
      :service_manage => false
    }}

    it { should_not contain_service('cron') }
  end
end
