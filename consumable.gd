extends Resource
class_name Consumable

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var inventory_id: String
@export var inventory_index: int

var signal_name

func update_amount(new_amount: int):
    amount = new_amount
    emit_signal(signal_name, id, amount)

func _init(name: String):
    id = name
    signal_name = id + "_updated"
    add_user_signal(signal_name, [id, amount])
