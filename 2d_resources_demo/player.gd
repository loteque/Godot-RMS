extends CharacterBody2D

@export var controlls: Node
@export var inventory_config: Node

var inventory

func _ready():
    controlls.player = self
    inventory_config.player = self
    inventory_config.create_inventory()


func _on_has_inventory_inventory_created(
    inventory_: Inventory
    ):
    inventory = inventory_
