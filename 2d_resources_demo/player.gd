extends CharacterBody2D

#this is representative of a user script 
#it should make calls to the lib
#at the surfaces and not use directly
#logic from the library. 

@export var controlls: Node
@export var inventory_config: Node

var inventory

func _ready():
    controlls.player = self
    
    # I have the notion that HasInventory
    # should inject these values into the
    # its parent obj when the parent obj is 
    # readied
    inventory_config.player = self
    inventory_config.create_inventory()

# I have the notion that HasInventory
# should inject these values into the
# player obj when the player obj is 
# readied
func _on_has_inventory_inventory_created(
    inventory_: Inventory
    ):
    inventory = inventory_
