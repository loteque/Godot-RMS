extends Node

var resource_containers = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for res_type_str in ResourceManager.resource_types:
		var res_type: ResourceType = ResourceManager.resource_types[res_type_str]
		var res_container = ResourceContainer.new(res_type)
		resource_containers[res_type_str] = res_container
