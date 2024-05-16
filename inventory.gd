extends ResourceContainer
class_name Inventory

@export var containers: Array[ResourceContainer]

func get_container_by_name(container_id) -> ResourceContainer:
    var selected: ResourceContainer
    if containers.is_empty():
        print("inventory is empty")

    # gonna need a better search
    for container in containers:
        if container.id == container_id:
            selected = container

    return selected

func add_container(container: ResourceContainer, cons_amount: int, cons_index: int):
    var selected = get_container_by_name(container.name)

    if selected:
        var new_amount = selected.amount + cons_amount
        selected.amount = new_amount
    else:
        containers.insert(cons_index, selected)

func remove_container(c_id: String):
    var selected = get_container_by_name(c_id)
    if !selected:
        return

    if selected:
        containers[selected.inventory_index] = null



