# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu-precise"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.hostname = "web01"

  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.provider :virtualbox do |vb|

    vb.gui = false

    vb.customize ["modifyvm", :id, "--memory", "512"]

  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "site.pp"

    puppet.options = "--verbose --debug"
    #puppet.options = "--verbose"
  end

end
