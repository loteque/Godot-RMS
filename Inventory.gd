extends Node
class_name Inventory

@export var player: Node
@export var container_size_limit: int 
@export var max_containers: int

var _metastore: Metastore

signal inventory_updated(inventory:Inventory)
signal added_store(store: Store)
signal removed_store(store: Store)
signal rejected_store(rejected_status)


func create_metastore(
    id,  
    metastore_index,  
    metastore_parent_id
):
    _metastore = Metastore.new(
        id,
        0,
        max_containers,
        metastore_index,
        container_size_limit,
        metastore_parent_id
    )
    inventory_updated.emit(self)


func get_metastore():
    if !_metastore:
        return
    return _metastore


func add_store(store):
    
    var metastore_size = _metastore.get_stores().size()
    var store_in_inventory = (
        _metastore
        .get_store_by_name(
            store.get_id()
        )
    )
    #TODO: these should be refactored to methods on their respective objects
    #-->
    var inventory_full = func():
        return _metastore.state == Metastore.STATE.full

    var store_message = func(target_store):
        if target_store:
            return (
                str(target_store.get_id())
                + " has "
                + str(_metastore.get_amount())
                + " space available."
            )
    #<--

    if metastore_size == max_containers:
        
        _metastore.state = Metastore.STATE.full

    if (inventory_full.call()):
        var new_store_message = (
            store_message.call(store_in_inventory)
        )
        rejected_store.emit(
            str(_metastore.get_id())
            + " max stores reached \n"
            + "inventory store: " 
            + str(new_store_message)

        )    
        return

    else:
        
        _metastore.add_store(store)
        inventory_updated.emit(self)
        added_store.emit(store)


func remove_store(store):
    
    var metastore_size = _metastore.get_stores().size()
    
    if (metastore_size > 0 
        and metastore_size < max_containers):
    
        _metastore.state = Metastore.STATE.partial
        _metastore.status = Metastore.STATUS.available
    
    elif metastore_size == 0:
    
        _metastore.state = Metastore.STATE.empty
        _metastore.status = Metastore.STATUS.available

    var selected = (
        _metastore
        .get_store_by_name(
            store.get_id()
        )
    )
    removed_store.emit(selected)
    _metastore.remove_store(selected.get_id())
    inventory_updated.emit(self)
