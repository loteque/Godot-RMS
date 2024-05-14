extends Resource
class_name Consumable

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var inventory_id: String
@export var inventory_index: int

## TODO: need unique signals for each instance of consumable
#signal amount_updated(name, amount)

var signal_name

func update_amount(new_amount: int):
    amount = new_amount
    emit_signal(signal_name, id, amount)

func create_consumable(name):
    
    var consumable = Consumable.new(name)
    consumable.amount = amount
    consumable.min_amount = min_amount
    consumable.max_amount = max_amount
    consumable.inventory_id = inventory_id
    consumable.inventory_index = inventory_index

func _init(name: String):
    id = name
    signal_name = id + "_updated"
    add_user_signal(signal_name, [id, amount])
