Vagrant::Config.run do |config|
	# NOTE: Ensure the box you use uses VirtualBox addons which match your host VirtualBox version
	config.vm.box       = 'quantal64vagrant'
	config.vm.box_url   = 'http://cloud-images.ubuntu.com/vagrant/quantal/current/quantal-server-cloudimg-amd64-vagrant-disk1.box'
	config.vm.host_name = 'appdevjs'

	# Accessible via NAT adapter
	#config.vm.forward_port 3000, 3000 
	# Accessible via hostonly adapter
	config.vm.network :hostonly, "192.168.56.103" # Static IP

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = 'puppet/manifests'
		puppet.module_path = 'puppet/modules'
		puppet.options = '-v'
	end
end
