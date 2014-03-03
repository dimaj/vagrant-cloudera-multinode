# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Node settings
  node_count = 1
  node_ram = 3072
  config.vm.box = "precise64"
  # config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  # Create hosts data
  hosts = "192.168.50.2 hadoop-master.local hadoop-master\n"
  node_count.times do |i|
    id = i+1
    hosts << "192.168.50.#{id+2} hadoop-node#{id}.local hadoop-node#{id}\n"
  end

  # config.ssh.pty = true
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Write hosts file
  config.vm.provision :shell, :inline => "echo \"#{hosts}\" | sudo tee -a /etc/hosts"
  config.vm.provision :shell, :inline => "echo \"\n#Add some DNS servers\nnameserver 8.8.8.8\nnameserver 8.8.4.4\" | sudo tee -a /etc/resolv.conf"
  config.vm.provision :shell, :inline => 'gem install puppet facter --no-rdoc --no-ri'
  config.vm.provision :shell, :inline => "sed -i '/127.0.1.1.*hadoop.*/d' /etc/hosts"

  # config.vm.provision :shell, :inline => 'apt-get update'

  # Manager
  config.vm.define :manager do |manager_config|
    manager_config.vm.hostname = "hadoop-master.local"
    manager_config.vm.network :forwarded_port, guest: 7180, host: 7180
    manager_config.vm.network :private_network, ip: "192.168.50.2"

    manager_config.vm.provider :virtualbox do |vb|
      # Boot with headless mode
      vb.gui = false
      # Use VBoxManage to customize the VM. For example to change memory:
      # vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["modifyvm", :id, "--memory", "#{node_ram}"]
    end

    manager_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "manager.pp"
      # puppet.manifest_file = "master.pp"

      puppet.module_path = ["modules"]
      # puppet.options = "--verbose --debug"
    end
  end

  # Create nodes
  node_count.times do |i|
    id = i+1
    config.vm.define "node#{id}" do |node_config|
      node_config.vm.hostname = "hadoop-node#{id}.local"
      node_config.vm.network :private_network, ip: "192.168.50.#{id+2}"
      node_config.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", "#{node_ram}"]
      end

      # node_config.vm.provision :puppet do |puppet|
      #   puppet.manifests_path = "manifests"
      #   puppet.module_path = ["modules"]
      #   puppet.manifest_file = "slave.pp"

      #   # puppet.options = "--verbose --debug"
      # end
    end
  end

end
