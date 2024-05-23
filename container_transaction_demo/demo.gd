extends Node

var gold: ResourceContainer
var player_inventory: Inventory

var output: TextEdit
var result: String = ""

func _ready():
    output = get_node("UI/Output")


    #send gold to the players inventory
    gold.send_update_to_inventory(player_inventory)


    #create a new gold with a value less than the players inventory space and add it to the scene
    var new_gold = gold.duplicate()
    new_gold.max_amount = 10
    new_gold.amount = 10
    add_child(new_gold)
    #send new gold to the players inventory
    new_gold.send_update_to_inventory(player_inventory)


    #create a new gold with a value greater than the players inventory space and add it to the scene
    var gold_110 = gold.duplicate()
    gold_110.max_amount = 110
    gold_110.amount = 110
    add_child(gold_110)
    #send new gold to the players inventory
    gold_110.send_update_to_inventory(player_inventory)
    

func _on_resource_container_created_container(container):
    result = result + "resource container created: " + str(container.get_id()) + "\n"
    result = result + "container max: " + str(container.get_max_amount()) + "\n"
    result = result + "container amount: " + str(container.get_amount()) + "\n"

func _on_resource_container_attached_container(attached_to):
    gold = attached_to
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


