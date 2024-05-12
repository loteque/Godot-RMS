extends VBoxContainer

@export var inv_panel: PackedScene
@export var inv_data: Node

func _on_consumable_created(cons_name, amount):
    pass

func _on_consumable_added(cons_name, amount):
    pass

func _on_consumable_subtracted(cons_name, amount):
    

func _ready():
    inv_data.consumable_created.connect(_on_consumable_created)
    inv_data.consumable_added.connect(_on_consumable_added)
    inv_data.consumable_subtracted.connect(_on_consumable_subtracted)

