extends Resource
class_name Consumable

@export var name: String
@export var amount: int
@export var regen: bool
@export var min_amount: int
@export var max_amount: int

signal amount_updated(name, amount)

func update_amount(new_amount: int):
    amount_updated.emit(name, new_amount)
    amount = new_amount
    