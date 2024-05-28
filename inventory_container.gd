extends ContainerResource
class_name InventoryContainer

var _containers: Array[ContainerResource]
var _container_max_size: int

enum REJECTED{
    containerTooLarge
}

func get_id():
    return _id

func get_containers():
    return _containers

func get_min_containers():
    return _min_amount

func get_max_containers():
    return _max_amount

func get_parent_inventory_id():
    return _inventory_id

func get_parent_inventory_index():
    return _inventory_index

func get_container_max_size():
    return _container_max_size

func get_container_by_name(container_id) -> ContainerResource:
    var selected: ContainerResource

    # gonna need a better search
    for container in _containers:
        if !container:
            print("inventory is empty")
            return selected

        #this match is case dependent
        if container._id == container_id:
            selected = container
        else:
            print("no match in inventory_container")
            
    print("looked up: " + container_id)
    print("found: " + str(selected))
    return selected

func add_container(container: ContainerResource, cons_index: int):
        if _containers.size() >= _max_amount:
            state = STATE.full
            return status
        
        if container._max_amount > _container_max_size:
            return REJECTED.containerTooLarge

        _containers.insert(cons_index, container)

func remove_container(c_id: String):
    var selected = get_container_by_name(c_id)

    if !selected:
        return

    if selected:
        _containers[selected._inventory_index] = null

func _init(
    inv_id: String,
    min_containers: int,
    max_containers: int,
    inv_idx: int,
    container_max_size: int,
    parent_inv_id: String = ""
):
    
    _id = inv_id
    _min_amount = min_containers
    _max_amount = max_containers
    _inventory_id = parent_inv_id
    _inventory_index = inv_idx
    _container_max_size = container_max_size
