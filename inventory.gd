extends ResourceContainer
class_name Inventory

@export var containers: Array[ResourceContainer]

signal added_container(container: Container)
signal removed_container(container: Container)

func get_container_by_name(container_id) -> ResourceContainer:
    var selected: ResourceContainer

    # gonna need a better search
    for container in containers:
        if !container:
            print("inventory is empty")
            return selected

        #this match is case dependent
        if container.id == container_id:
            selected = container

    print("looked up: " + container_id)
    print("found: " + str(selected))
    return selected

func add_container(container: ResourceContainer, cons_index):
        
        containers.insert(cons_index, container)
        added_container.emit(container)

func remove_container(c_id: String):
    var selected = get_container_by_name(c_id)

    if !selected:
        return

    if selected:
        containers[selected.inventory_index] = null



