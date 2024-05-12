extends HBoxContainer

@onready var resource_name = $ResourceName
@onready var resource_value = $ResourceValue
@onready var collect_button: Button = $CollectButton

var item_container: ResourceContainer
var collect_amt: int = 10
var start_amt: int = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	item_container.container_changed.connect(_on_resource_value_change)
	resource_name.text = item_container.get_resource_name()
	resource_value.text = str(item_container.get_current())
	collect_button.pressed.connect(_on_collect_pressed)
	item_container.add(start_amt)

func _on_resource_value_change(value: int):
	resource_value.text = item_container.get_current()

func set_item_container(cont: ResourceContainer):
	item_container = cont

func _on_collect_pressed():
	var receiving_container: ResourceContainer = PlayerResources.resource_containers[item_container.get_resource_name()]
	if item_container.can_remove(collect_amt) and receiving_container.can_add(collect_amt):
		receiving_container.add(collect_amt)
		item_container.remove(collect_amt)
