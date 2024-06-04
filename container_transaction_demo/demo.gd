extends Node
    #todo: #17 finish testing all signal scenarios in demo
@export var gold: ResourceContainer
@export var player_inventory: Inventory
@export var output: TextEdit

var result: String = ""

func _ready():
    output = get_node("UI/Output")
    player_inventory.create_metastore("player_inventory_metastore", 0, "")
    gold.send_update_to_inventory(player_inventory)

    var new_gold = ResourceContainer.new()
    new_gold.id = "gold"
    new_gold.min_amount = 0
    new_gold.max_amount = 10
    new_gold.amount = 10
    new_gold.connect("created_store", _on_resource_container_created_store)
    new_gold.connect("attached_store", _on_resource_container_attached_store)
    new_gold.connect("transaction_executed", _on_resource_container_transaction_executed)
    new_gold.connect("updated_store", _on_resource_container_updated_store)
    new_gold.connect("removed_resource_container", _on_removed_resource_container)
    add_child(new_gold)
    new_gold.send_update_to_inventory(player_inventory)

    var create_resource = func(id: String, amount: int):
        var resource = ResourceContainer.new() 
        resource.id = id
        resource.min_amount = 0
        resource.max_amount = amount
        resource.amount = amount
        resource.connect("created_store", _on_resource_container_created_store)
        resource.connect("attached_store", _on_resource_container_attached_store)
        resource.connect("transaction_executed", _on_resource_container_transaction_executed)
        resource.connect("updated_store", _on_resource_container_updated_store)
        resource.connect("removed_resource_container", _on_removed_resource_container)
        add_child(resource)
        return resource

    gold = create_resource.call("gold", 10)
    gold.send_update_to_inventory(player_inventory)

    var gold_110 = create_resource.call("gold_110", 110)
    gold_110.send_update_to_inventory(player_inventory)

    create_resource.call("gold", 10)     
    gold.send_update_to_inventory(player_inventory)

    gold = create_resource.call("gold", 110)      
    gold.send_update_to_inventory(player_inventory)

    var water = create_resource.call("water", 10)
    water.send_update_to_inventory(player_inventory)

    player_inventory.remove_store(
        player_inventory
        .get_metastore()
        .get_store_by_name("gold")
    )

    water.send_update_to_inventory(player_inventory)

    output.text = result

func _on_inventory_added_store(store):
    result = (
        result 
        + "added store to player inventory: " 
        + str(store.get_id()) 
        + "\n"
    )


func _on_inventory_removed_store(store: Store):
    result = (
        result 
        + "removed store " 
        + str(store.get_id()) 
        + " from inventory " 
        + str(player_inventory.get_metastore().get_id()) 
        + "\n"
    )


func _on_inventory_updated(inventory):
    player_inventory = inventory
    result = (
        result 
        + "inventory updated: " 
        + str(inventory.name) 
        + "\n"
    )
    result = (
        result 
        + "inventory containers: " 
        + str(
            inventory
            .get_metastore()
            .get_stores()
            .size()
        ) 
        + "\n"
    )


func _on_inventory_rejected_store(rejected_status):
    result = ( 
        result 
        + "store rejected: " 
        + str(rejected_status) 
        + "\n"
    )


func _on_resource_container_created_store(store):
    result = (
        result 
        + "store created, id: " 
        + str(store.get_id()) 
        + "\n"
    )
    result = (
        result 
        + "store max: " 
        + str(store.get_max_amount()) 
        + "\n"
    )
    result = (
        result 
        + "store amount: " 
        + str(store.get_amount()) 
        + "\n"
    )


func _on_resource_container_attached_store(attached_to):
    result = (
        result 
        + "container attached to: " 
        + str(attached_to.id) 
        + "\n"
    )


func _on_resource_container_transaction_executed(transaction, exit_status):
    result = (
        result 
        + "transaction id: " 
        + str(transaction.get_id()) 
        + "\n"
    )
    result = (
        result 
        + "transaction amount: " 
        + str(transaction.get_rate()) 
        + "\n"
    )
    
    if exit_status.get_error() == transaction.ERROR.success:
        result = (
            result 
            + "transaction success\n"
        )
        result = (
            result 
            + "transaction overflow: " 
            + str(exit_status.get_overflow()) 
            + "\n"
        )
        transaction.get_sender().add(exit_status.get_overflow())
    else:
        result = (
            result 
            + "transaction failed; error code: " 
            + str(exit_status.get_error()) 
            + "\n"
        )


func _on_resource_container_updated_store(id:String, amount:int, inventory_id):
    result = (
        result 
        + "container updated: " 
        + str(inventory_id) 
        + " has " 
        + str(amount) 
        + " " + str(id) 
        + "\n"
    )
    result = result + "----------------\n"
    output.text = result


func _on_removed_resource_container(removed_from:Node):
    result = (
        result 
        + "removed container from " 
        + str(removed_from.name) 
        + "\n----------------\n"
    )
