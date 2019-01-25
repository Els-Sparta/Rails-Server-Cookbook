#
# Cookbook:: rails-server
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rails-server::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should update the packages' do
      expect(chef_run).to update_apt_update('update')
    end

    it 'should retrieve the apt_repository for ruby 2.4' do
      expect(chef_run).to add_apt_repository('ruby2.4')
    end

    it 'should install ruby 2.4' do
      expect(chef_run).to install_package 'ruby2.4'
    end

    it 'should install ruby 2.4-dev' do
      expect(chef_run).to install_package 'ruby2.4-dev'
    end

    it 'should install gem_package bundler' do
      expect(chef_run).to install_gem_package 'bundler'
    end

    it 'should install rails' do
      expect(chef_run). to install_gem_package 'rails'
    end

    it "should install nginx" do
      expect(chef_run).to install_package 'nginx'
    end

    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template("/etc/nginx/sites-available/proxy.conf")
    end

    it 'should create a symlink of proxy.conf from sites-available to sites-enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end

    it 'should delete the symlink from the default config in sites-enabled' do
      expect(chef_run).to delete_link("/etc/nginx/sites-enabled/default")
    end

    it 'should add file /tmp/nodesource_setup.sh' do
      expect(chef_run).to create_remote_file('/tmp/nodesource_setup.sh')
    end

    it 'should execute update node resources' do
      expect(chef_run).to run_execute('update node resources')
    end

    it "should install git-core" do
      expect(chef_run).to install_package 'git-core'
    end

    it "should install build-essential" do
      expect(chef_run).to install_package 'build-essential'
    end

    it "should install nodejs" do
      expect(chef_run).to install_package 'nodejs'
    end

    it "should install libpq-dev" do
      expect(chef_run).to install_package 'libpq-dev'
    end

    it "should install apt-transport-https" do
      expect(chef_run).to install_package 'apt-transport-https'
    end

    it "should install ca-certificates" do
      expect(chef_run).to install_package 'ca-certificates'
    end

    # it "should install zlib1g-dev" do
    #   expect(chef_run).to install_package 'zlib1g-dev'
    # end

    # it "should install libssl-dev" do
    #   expect(chef_run).to install_package 'libssl-dev'
    # end
    #
    # it "should install libreadline-dev" do
    #   expect(chef_run).to install_package 'libreadline-dev'
    # end
    #
    # it "should install libyaml-dev" do
    #   expect(chef_run).to install_package 'libyaml-dev'
    # end
    #
    #
    # it "should install libxml2-dev" do
    #   expect(chef_run).to install_package 'libxml2-dev'
    # end
    #
    # it "should install libxslt1-dev" do
    #   expect(chef_run).to install_package 'libxslt1-dev'
    # end
    #
    # it "should install libcurl4-openssl-dev" do
    #   expect(chef_run).to install_package 'libcurl4-openssl-dev'
    # end

    # it "should install libffi-dev" do
    #   expect(chef_run).to install_package 'libffi-dev'
    # end
  end
end
