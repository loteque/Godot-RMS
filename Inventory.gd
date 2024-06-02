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

func create_metastore():
    _metastore = Metastore.new(
        str(player.get_name()) + "_metastore",
        0,
        10,
        0,
        100
    )
    inventory_updated.emit(self)

func get_metastore():
    if !_metastore:
        return
    return _metastore

func add_store(store, idx):
    if _metastore.get_stores().size() >= max_containers:
        return
    
    _metastore.add_store(store, idx)
    added_store.emit(store)

func remove_store(store):
    var selected = _metastore.get_store_by_name(store.get_id())
    removed_store.emit(selected)
    _metastore.remove_store(selected.get_id())
    
func _ready():
    create_metastore()
