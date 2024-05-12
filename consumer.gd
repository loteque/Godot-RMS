extends Resource
class_name Consumer

@export var name: String
@export var is_auto: bool
@export var rate: int
@export var sink: Inventory

signal consumed(consumable, amount)

func consume(consumable):
    consumed.emit(rate)
    sink.add_consumable(consumable, rate)
    return consumable.amount - rate

