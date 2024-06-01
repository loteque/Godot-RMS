extends Node
    #todo: #17 finish testing all signal scenarios in demo
@export var gold: ResourceContainer
var player_inventory: Inventory

var output: TextEdit
var result: String = ""

func _ready():
    output = get_node("UI/Output")

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
    new_gold.connect("removed_store", _on_resource_container_removed_store)
    add_child(new_gold)
    new_gold.send_update_to_inventory(player_inventory)

    gold = ResourceContainer.new()
    gold.id = "gold"
    gold.min_amount = 0
    gold.max_amount = 10
    gold.amount = 10
    gold.connect("created_store", _on_resource_container_created_store)
    gold.connect("attached_store", _on_resource_container_attached_store)
    gold.connect("transaction_executed", _on_resource_container_transaction_executed)
    gold.connect("updated_store", _on_resource_container_updated_store)
    gold.connect("removed_store", _on_resource_container_removed_store)
    add_child(gold)
    gold.send_update_to_inventory(player_inventory)

    var gold_110 = gold.duplicate()
    gold_110.max_amount = 110
    gold_110.amount = 110
    add_child(gold_110)
    gold_110.connect("created_store", _on_resource_container_created_store)
    gold_110.connect("attached_store", _on_resource_container_attached_store)
    gold_110.connect("transaction_executed", _on_resource_container_transaction_executed)
    gold_110.connect("updated_store", _on_resource_container_updated_store)
    gold_110.connect("removed_store", _on_resource_container_removed_store)   
    gold_110.send_update_to_inventory(player_inventory)
    
    gold = ResourceContainer.new()
    gold.id = "gold"
    gold.max_amount = 110
    gold.amount = 110
    add_child(gold)
    gold.connect("created_store", _on_resource_container_created_store)
    gold.connect("attached_store", _on_resource_container_attached_store)
    gold.connect("transaction_executed", _on_resource_container_transaction_executed)
    gold.connect("updated_store", _on_resource_container_updated_store)
    gold.connect("removed_store", _on_resource_container_removed_store)   
    gold.send_update_to_inventory(player_inventory)

func _on_resource_container_created_store(store):
    result = result + "store created, id: " + str(store.get_id()) + "\n"
    result = result + "store max: " + str(store.get_max_amount()) + "\n"
    result = result + "store amount: " + str(store.get_amount()) + "\n"


func _on_resource_container_attached_store(attached_to):
    result = result + "container attached to: " + str(attached_to.id) + "\n"

func _on_inventory_updated(inventory):
    player_inventory = inventory
    result = result + "inventory updated: " + str(inventory.name) + "\n"

func _on_inventory_added_store(store):
    result = result + "added store to player inventory: " + str(store.get_id()) + "\n"

func _on_resource_container_transaction_executed(transaction, exit_status):
    result = result + "transaction id: " + str(transaction.get_id()) + "\n"
    result = result + "transaction amount: " + str(transaction.get_rate()) + "\n"
    
    if exit_status.get_error() == transaction.ERROR.success:
        result = result + "transaction success\n"
        result = result + "transaction overflow: " + str(exit_status.get_overflow()) + "\n"
        transaction.get_sender().add(exit_status.get_overflow())
    else:
        result = result + "transaction failed with error code: " + str(exit_status.get_error()) + "\n"

func _on_resource_container_updated_store(id:String, amount:int, inventory_id):
    result = result + "container updated: " + str(inventory_id) + " has " + str(amount) + " " + str(id) + "\n"
    output.text = result

func _on_resource_container_removed_store(removed_from:ResourceContainer):
    result = result + "removed container from " + str(removed_from) + "\n"
    