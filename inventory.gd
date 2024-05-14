extends Consumable
class_name Inventory

@export var consumables: Array[Consumable]

func get_consumable_by_name(consumable_id) -> Consumable:
    var selected: Consumable
    if consumables.is_empty():
        print("inventory is empty")

    # gonna need a better search
    for consumable in consumables:
        if consumable.id == consumable_id:
            selected = consumable

    return selected

func add_consumable(consumable: Consumable, cons_amount: int, cons_index: int):
    var selected = get_consumable_by_name(consumable.name)

    if selected:
        var new_amount = selected.amount + cons_amount
        selected.amount = new_amount
    else:
        consumables.insert(cons_index, selected)

func remove_consumable(c_id: String):
    var selected = get_consumable_by_name(c_id)
    if !selected:
        return

    if selected:
        consumables[selected.inventory_index] = null



