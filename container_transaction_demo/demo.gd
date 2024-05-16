extends Control

var container_panel: PackedScene = preload("res://container_transaction_demo/container_panel.tscn")

func _ready():
    
    var player_photons_panel = container_panel.instantiate().create_container("player_photons", 0, 0, 10)
    %PlayerConsumables.add_child(player_photons_panel)
    
    var world_photons_panel = container_panel.instantiate().create_container("world_photons", 11, 0, 12)
    %WorldConsumables.add_child(world_photons_panel)


    player_photons_panel.container.transaction = Transaction.new(player_photons_panel.container,
                                            player_photons_panel.container, 
                                            "consume_one",
                                            false,
                                            1)
    
    world_photons_panel.container.transaction = Transaction.new(world_photons_panel.container, 
                                            player_photons_panel.container,
                                            "transfer_one",
                                            false,
                                            1)
