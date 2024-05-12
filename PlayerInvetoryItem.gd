extends HBoxContainer

var item_container: ResourceContainer

@onready var resource_name = $ResourceName
@onready var resource_value = $ResourceValue

# Called when the node enters the scene tree for the first time.
func _ready():
	item_container.container_changed.connect(_on_resource_value_change)
	resource_name.text = item_container.get_resource_name()
	resource_value.text = str(item_container.get_current())

func _on_resource_value_change(value: int):
	resource_value.text = item_container.get_current()

func set_item_container(cont: ResourceContainer):
	item_container = cont
