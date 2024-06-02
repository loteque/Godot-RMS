extends Store
class_name Metastore

var _stores: Array[Store]
var _store_max_size: int

enum REJECTED{
    storeTooLarge
}

func get_id():
    return _id

func get_stores():
    return _stores

func get_min_stores():
    return _min_amount

func get_max_stores():
    return _max_amount

func get_parent_metastore_id():
    return _metastore_id

func get_parent_metastore_index():
    return _metastore_index

func get_store_max_size():
    return _store_max_size

func get_store_by_name(store_id) -> Store:
    var selected: Store

    # TODO: #13 gonna need a better search
    for store in _stores:
        if !store:
            print("inventory is empty")
            return selected

        #this match is case dependent
        if store._id == store_id:
            selected = store
        else:
            # TODO: #15 MetaStore::get_store_by_name() needs info and error handling
            print("no match in inventory_container")

    return selected

func add_store(store: Store, metastore_index: int):
        if _stores.size() >= _max_amount:
            state = STATE.full
            return status
        
        if store._max_amount > _store_max_size:
            return REJECTED.storeTooLarge

        _stores.insert(metastore_index, store)

func remove_store(store_id: String):
    var selected = get_store_by_name(store_id)

    if !selected:
        return

    if selected:
        _stores[selected.get_inventory_index()] = null

func _init(
    id: String,
    min_stores: int,
    max_stores: int,
    metastore_index: int,
    store_max_size: int,
    parent_metastore_id: String = ""
):
    
    _id = id
    _min_amount = min_stores
    _max_amount = max_stores
    _metastore_id = parent_metastore_id
    _metastore_index = metastore_index
    _store_max_size = store_max_size
