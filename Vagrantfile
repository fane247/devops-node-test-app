required_plugins = ['vagrant-hostsupdater', 'vagrant-berkshelf']
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end


Vagrant.configure("2") do |config|

  config.vm.define "web" do |web|

    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.10.101"
    web.hostsupdater.aliases = ["development.local"]
    web.vm.synced_folder ".", "/home/ubuntu/app"
    # web.vm.provision "shell", path: "environment/box_web/provisioning.sh"
    web.vm.provision "shell", inline: "echo 'export DB_HOST=mongodb://192.168.10.102/test' >> .bash_profile"

    web.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = ['cookbooks']
      chef.run_list = ['recipe[node_app::default]']
    end

  end

  config.vm.define "db" do |db|

    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.102"
    db.hostsupdater.aliases = ["db.local"]
    db.vm.synced_folder "./environment/box_db", "/home/ubuntu/app/environment/box_db"
    # db.vm.provision "shell", path: "environment/box_db/provision.sh"

    db.vm.provision "chef_solo" do |chef|

      chef.run_list = ['recipe[mongo::default]']

    end

  end


end
