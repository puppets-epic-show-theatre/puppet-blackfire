require 'spec_helper'
describe 'blackfire' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with default parameters' do
        it do
          expect {
            is_expected.to compile
          }.to raise_error(%r{server_id and server_token are required.})
        end
      end

      context 'with minimum parameters (server id and token)' do
        let(:params) do
          {
            server_id: 'foo',
            server_token: 'bar',
          }
        end

        context 'with minimum set of parameters' do
          it { is_expected.to compile }
          it { is_expected.to contain_class('blackfire') }
          it { is_expected.to contain_class('blackfire::repo') }
          it { is_expected.to contain_class('blackfire::agent') }
          it { is_expected.to contain_class('blackfire::php') }
        end

        context 'agent package' do
          it { is_expected.to contain_package('blackfire-agent').with(ensure: 'latest') }
        end

        context 'agent configuration' do
          it {
            is_expected.to contain_ini_setting('server-id').with(
            path: '/etc/blackfire/agent',
            value: 'foo',
          )
          }
          it {
            is_expected.to contain_ini_setting('server-token').with(
            path: '/etc/blackfire/agent',
            value: 'bar',
          )
          }
        end

        context 'agent service' do
          it { is_expected.to contain_service('blackfire-agent').with(ensure: 'running') }
        end

        context 'probe package' do
          it { is_expected.to contain_package('blackfire-php').with(ensure: 'latest') }
        end

        context 'probe configuration' do
          it {
            is_expected.to contain_ini_setting('blackfire.server_id').with(
            value: 'foo',
          )
          }
          it {
            is_expected.to contain_ini_setting('blackfire.server_token').with(
            value: 'bar',
          )
          }
        end
      end
    end
  end
end
