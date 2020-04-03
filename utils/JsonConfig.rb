#!/usr/bin/ruby

######################################
# Name : JsonConfig.rb
# Author : Umesh Soni
# Desc : class to fetch data from json file
######################################

require "json"

class JsonConfig
	@data

	def initialize(file_name)
		file = File.read(file_name)
		@data = JSON.parse(file)
	end

	def getNodeNum(node_type)
		return @data["nodes"][node_type].length
  end

  def getNodeMemory(node_type, num)
	  return @data["nodes"][node_type][num]["memory"]
  end

	def getNodeCPU(node_type, num)
		return @data["nodes"][node_type][num]["cpu"]
	end

	def getNodeIP(node_type, num)
		return @data["nodes"][node_type][num]["ip"]
	end

	def getVBoxImageName()
		return @data["common"]["vbox_image"]
	end

	def getKubernetesVersion()
		return @data["common"]["kubernetes_version"]
	end

	def getPodNetworkCIDR()
		return @data["common"]["pod_network_cidr"]
	end

	def getNodeTypes()
		return @data["nodes"].keys
	end
end
