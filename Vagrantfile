Vagrant.configure("2") do |config|
    config.vm.box = "bento/amazonlinux-2"
    config.vm.provision "chef_solo" do |chef|
      chef.arguments = "--chef-license accept"
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe 'rabbitmq'
    end
  end
