require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'libreoffice' do

  let(:title) { 'libreoffice' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42', :operatingsystem => 'Debian', :hardwaremodel => 'x86' } }

  describe 'Test standard installation' do
    it { should contain_package('libreoffice').with_ensure('present') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('libreoffice').with_ensure('present') }
    it { should contain_wget__fetch('libreoffice_1.0.42') }
  end

  describe 'Test installation of a specific URL' do
    let(:params) { {:url => 'http://example.42/libreoffice.tgz', :version => '1.0.42' } }
    it { should contain_wget__fetch('libreoffice_1.0.42').with_source('http://example.42/libreoffice.tgz') }
  end

  describe 'Test default URL generation' do
    let(:params) { {:version => '3.5.4' } }
    it { should contain_wget__fetch('libreoffice_3.5.4').with_source('http://freefr.dl.sourceforge.net/project/libreoffice.mirror/LibreOffice%203.5.4/LibO_3.5.4_Linux_x86_install-deb_en-US.tar.gz') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true } }

    it 'should remove Package[libreoffice]' do should contain_package('libreoffice').with_ensure('absent') end
    it 'should remove libreoffice installation package' do should contain_file('libreoffice_package').with_ensure('absent') end
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "libreoffice::spec" } }
    it 'should automatically include a custom class' do
      content = catalogue.resource('file', 'libreoffice.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
  end

end
