extends Resource
class_name Inventory

@export var inventory_name: String 
@export var consumables: Array[Consumable]

signal consumable_added(name, amount)
signal consumable_subtracted(name, amount)
signal consumable_created(name, amount)

func get_consumable_by_name(consumable_name) -> Consumable:
    var selected: Consumable
    if consumables.is_empty():
        print("inventory is empty")

    # gonna need a better search
    for consumable in consumables:
        if consumable.name == consumable_name:
            selected = consumable

    return selected

func add_consumable(consumable: Consumable, amount: int):
    var selected = get_consumable_by_name(consumable.name)

    if selected:
        var new_amount = selected.amount + amount
        selected.amount = new_amount
    else:
        consumables.append(consumable)
        consumable_created.emit(consumable.name, amount)

    consumable_added.emit(consumable.name, amount)

func subtract_consumable(consumable: Consumable, amount: int):
    var selected = get_consumable_by_name(consumable.name)
    if !selected:
        return

    if selected:
        selected.amount = selected.amount - amount

    consumable_subtracted.emit(consumable.name, amount)



