extends Resource
class_name Consumer

@export var name: String
@export var is_auto: bool
@export var rate: int

signal subtracted(consumable, amount)
signal added(consumable, amount)

func subtract(consumable):
    subtracted.emit(rate)
    return consumable.amount - rate

func add(consumable):
    added.emit(rate)
    return consumable.amount + rate

