load "utils/JsonConfig.rb"

ENV["LC_ALL"] = "en_US.UTF-8"

configFileName = "config.json"
$json_config = JsonConfig.new(configFileName)

Vagrant.configure(2) do |config|
	config.vm.box = $json_config.getVBoxImageName()
	node_types = $json_config.getNodeTypes()

	node_types.each do |node_type|
		node_num = $json_config.getNodeNum(node_type)
		node_num.times do |i|
			config.vm.define "#{node_type}_#{i + 1}" do |config|
				config.vm.hostname = "#{node_type}-#{i + 1}"
				config.vm.network :private_network, ip: $json_config.getNodeIP(node_type, i)
				set_provider_config(config, node_type, i)
				start_ansible(config, node_type, i)
			end
		end
	end
end

def set_provider_config(config, node_type, index)
	config.vm.provider :virtualbox do |vbox|
		vbox.memory = $json_config.getNodeMemory(node_type, index)
		vbox.cpus = $json_config.getNodeCPU(node_type, index)
	end
end

def start_ansible(config, node_type, i)
	k8s_version = $json_config.getKubernetesVersion()
	pod_cidr = $json_config.getPodNetworkCIDR()
	ip_address = $json_config.getNodeIP(node_type, i)

	# Run Prerequisites ansible
	config.vm.provision "Prerequisites", type: 'ansible' do |ansible|
		ansible.playbook = "playbooks/prerequisites.yaml"
		ansible.compatibility_mode = "2.0"
		ansible.extra_vars = {
				version: "#{k8s_version}"
		}
	end

	# Run Setup Node ansible
	case node_type
	when "master"
		config.vm.provision "Setup_Master", type: 'ansible' do |ansible|
			ansible.playbook = "playbooks/setup_master.yaml"
			ansible.compatibility_mode = "2.0"
			ansible.extra_vars = {
					ip_address: "#{ip_address}",
					pod_cidr: "#{pod_cidr}"
			}
		end
	when "workers"
		config.vm.provision "Setup_Workers", type: 'ansible' do |ansible|
			ansible.playbook = "playbooks/setup_workers.yaml"
			ansible.compatibility_mode = "2.0"
			ansible.become = true
			ansible.extra_vars = {}
		end
	end
end