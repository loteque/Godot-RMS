extends Control

# Load the packed scene for items
#var item_scene = preload("res://ResourceTypeLineItemEdit.tscn")
var resource_types = []
var file_path: String = "res://resource_types.json"

@onready var add_new_button = %AddNewButton
@onready var save_button = %SaveButton


func _ready():
	add_new_button.connect("pressed", _on_AddNew_pressed)
	save_button.connect("pressed", _on_Save_pressed)
	load_resource_types()
	update_ui()

func load_resource_types():
	var data = JSON.parse_string(load_file())
	resource_types = data

func update_ui():
	for child in %LineItemList.get_children():
		child.queue_free()  # Clear existing UI elements

	for resource_type in resource_types:
		#var item = item_scene.instantiate()
		var item = VBoxContainer.new()
		for field in resource_type:
			var item_field = HBoxContainer.new()
			item.add_child(item_field)
			var field_label = Label.new()
			field_label.text = field
			item_field.add_child(field_label)
			var value_edit = LineEdit.new()
			value_edit.text = resource_type[field]
			item_field.add_child(value_edit)
		var delete_button = Button.new()
		delete_button.text = "Delete"
		item.add_child(delete_button)
		delete_button.pressed.connect(_on_delete_pressed)
		%LineItemList.add_child(item)

func _on_delete_pressed(name):
	resource_types.erase(resource_types.find(name))
	update_ui()

func _on_AddNew_pressed():
	resource_types.append({"name": ""})  # Add new empty resource type
	update_ui()

func _on_Save_pressed():
	save_file(JSON.stringify(resource_types))

func save_file(content):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(content)

func load_file():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	return content

func _on_LineEdit_text_changed(new_text, resource_type):
	resource_type.name = new_text

