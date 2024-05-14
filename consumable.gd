extends Resource
class_name Consumable

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var inventory_id: String
@export var inventory_index: int

## TODO: need unique signals for each instance of consumable
signal amount_updated(name, amount)

func update_amount(new_amount: int):
    amount_updated.emit(id, new_amount)
    amount = new_amount

func create_consumable():
    
    var consumable = Consumable.new()
    consumable.id = id
    consumable.amount = amount
    consumable.min_amount = min_amount
    consumable.max_amount = max_amount
    consumable.inventory_id = inventory_id
    consumable.inventory_index = inventory_index