extends Node

class_name ResourceManager

var resources_data = preload("res://resource_types.json")
var resource_dict = JSON.parse_string(resources_data)
static var resource_types = {
	"Wood": ResourceType.new("Wood"),
	"Metal": ResourceType.new("Metal"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
