extends Node

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
    new_gold.connect("created_container", _on_resource_container_created_container)
    new_gold.connect("attached_container", _on_resource_container_attached_container)
    new_gold.connect("transaction_executed", _on_resource_container_transaction_executed)
    new_gold.connect("updated_container", _on_resource_container_updated_container)
    new_gold.connect("removed_container", _on_resource_container_removed_container)
    add_child(new_gold)
    new_gold.send_update_to_inventory(player_inventory)

    gold = ResourceContainer.new()
    #TODO: #4 Should ID actually be "resource_type" or "type"?
    gold.id = "gold"
    gold.min_amount = 0
    gold.max_amount = 10
    gold.amount = 10
    gold.connect("created_container", _on_resource_container_created_container)
    gold.connect("attached_container", _on_resource_container_attached_container)
    gold.connect("transaction_executed", _on_resource_container_transaction_executed)
    gold.connect("updated_container", _on_resource_container_updated_container)
    gold.connect("removed_container", _on_resource_container_removed_container)
    add_child(gold)
    gold.send_update_to_inventory(player_inventory)

    var gold_110 = gold.duplicate()
    gold_110.max_amount = 110
    gold_110.amount = 110
    add_child(gold_110)
    gold_110.connect("created_container", _on_resource_container_created_container)
    gold_110.connect("attached_container", _on_resource_container_attached_container)
    gold_110.connect("transaction_executed", _on_resource_container_transaction_executed)
    gold_110.connect("updated_container", _on_resource_container_updated_container)
    gold_110.connect("removed_container", _on_resource_container_removed_container)   
    #TODO: #5 ecxess gold should remain in its original container
    gold_110.send_update_to_inventory(player_inventory)
    
func _on_resource_container_created_container(container):
    result = result + "resource container created: " + str(container.get_id()) + "\n"
    result = result + "container max: " + str(container.get_max_amount()) + "\n"
    result = result + "container amount: " + str(container.get_amount()) + "\n"


func _on_resource_container_attached_container(attached_to):
    result = result + "container attached to: " + str(attached_to.id) + "\n"

func _on_inventory_inventory_created(inventory):
    player_inventory = inventory
    result = result + "inventory created: " + str(inventory.name) + "\n"

func _on_inventory_added_container(container):
    result = result + "added container to player inventory: " + str(container.get_id()) + "\n"

func _on_resource_container_transaction_executed(transaction, exit_status):
    result = result + "transaction id: " + str(transaction.get_id()) + "\n"
    result = result + "transaction amount: " + str(transaction.get_rate()) + "\n"
    
    if exit_status == 0:
        result = result + "transaction success\n"
    else:
        result = result + "transaction failed with error code: " + str(exit_status) + "\n"

func _on_resource_container_updated_container(id:String, amount:int, inventory_id):
    result = result + "container updated: " + str(inventory_id) + " has " + str(amount) + " " + str(id) + "\n"
    output.text = result

func _on_resource_container_removed_container(removed_from:ResourceContainer):
    result = result + "removed container from " + str(removed_from) + "\n"
    