# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider :virtualbox do |vb, override|

    override.vm.box = "angular-vm"
    override.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
    override.vm.network :private_network, ip: "192.168.33.10"
    override.vm.hostname = "angular-vm"

    override.ssh.forward_agent = true

    override.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet-manifests"
      puppet.manifest_file  = "site.pp"
      puppet.module_path = "puppet-modules"
      # puppet 3 complains about a missing hiera.yml file, so explicity set the default.
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
      # puppet complains about fqdn (fully qualified domain name)
      puppet.facter = { "fqdn" => "angular-vm.local", "hostname" => "angular-vm" }
    end
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    # Enter your digital ocean credentials here.
    provider.client_id = ''
    provider.api_key = ''

    provider.image = 'Ubuntu 14.04 x64'
    override.vm.provision :shell, :path => "puppet-manifests/bootstrap-scripts/ubuntu.sh"

    override.vm.provision :puppet do |puppet|
      #TODO This installs everything on digital ocean, but bower install and grunt serve fail. After logging in,
      # I could start grunt serve and see the page at the url of the box.
      puppet.manifests_path = "puppet-manifests"
      puppet.manifest_file  = "site.pp"
      puppet.module_path = "puppet-modules"
      # puppet 3 complains about a missing hiera.yml file, so explicity set the default.
      puppet.options = "--hiera_config /vagrant/hiera.yaml"
      # puppet complains about fqdn (fully qualified domain name)
      puppet.facter = { "fqdn" => "angular-vm.local", "hostname" => "angular-vm" }
    end
  end
end
