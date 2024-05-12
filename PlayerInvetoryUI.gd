extends VBoxContainer

var inv_item_scene = preload("res://PlayerInventoryItemUI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for res_container_str in PlayerResources.resource_containers:
		var inv_item_node = inv_item_scene.instantiate()
		inv_item_node.set_item_container(PlayerResources.resource_containers[res_container_str])
		add_child(inv_item_node)
