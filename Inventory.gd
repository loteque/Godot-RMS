extends Node
class_name Inventory

@export var player: Node
@export var container_size_limit: int 
@export var max_containers: int

var _inventory: Metastore

signal inventory_created(inventory:Inventory)
signal added_container(container: Store)
signal removed_container(container: Store)
signal container_rejected(rejected_status)

func create_inventory():
    _inventory = Metastore.new(
        str(player.get_name()) + "_inventory",
        0,
        10,
        0,
        100
    )
    inventory_created.emit(self)

func get_inventory():
    if !_inventory:
        return
    return _inventory

func add_container(container, idx):
    if _inventory.get_stores().size() >= max_containers:
        return
    
    _inventory.add_container(container, idx)
    added_container.emit(container)

func _ready():
    create_inventory()
