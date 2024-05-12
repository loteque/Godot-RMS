extends VBoxContainer

var res_node_ui_scene = preload("res://ResourceNodeUI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for res_container_str in PlayerResources.resource_containers:
		var player_container: ResourceContainer = PlayerResources.resource_containers[res_container_str]
		var new_container = ResourceContainer.new(player_container.res_type)
		var res_node = res_node_ui_scene.instantiate()
		res_node.set_item_container(new_container)
		add_child(res_node)
