extends Node

@export var player_ui: CanvasLayer
var container_panel_scene: PackedScene = preload("res://2d_resources_demo/container_panel.tscn") 


var player: CharacterBody2D

signal inventory_created(inventory:Inventory)

func create_inventory():
    var inventory: Inventory
    inventory = Inventory.new(
        str(player.get_name()) + "_inventory",
        10,
        0,
        10
    )
    inventory.added_container.connect(_on_container_added)
    inventory.removed_container.connect(_on_container_removed)
    inventory_created.emit(inventory)

func _on_container_added(container):
    var container_panel = container_panel_scene.instantiate()
    container_panel.add_container(container)
    player_ui.resource_list.add_child(container_panel)

func _on_container_removed(_container):
    pass
