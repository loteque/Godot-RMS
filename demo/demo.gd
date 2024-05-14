extends Control

var consume_by_one: Consumer
var photon_consumable: Consumable
var player_consumable_1: Consumable

func _on_photons_updated(_name, amount):
    %WorldConsumables/ConsumablePanel.amount_label.text = str(amount)

func _on_player_photons_updated(_name, amount):
    %PlayerConsumables/ConsumablePanel.amount_label.text = str(amount)

func _ready():
    # feels like way to much typing to add consumables.
    # maybe predefined values from a json or tres could be used to initialize new consumables.
    # We can dynamically generate these values at runtime so that is a plus
    player_consumable_1 = Consumable.new("player_photons")
    player_consumable_1.amount = 0
    player_consumable_1.min_amount = 0
    player_consumable_1.max_amount = 1000
    player_consumable_1.inventory_id = "None"
    player_consumable_1.inventory_index = 0
    player_consumable_1.connect("player_photons_updated", _on_player_photons_updated)
    %PlayerConsumables/ConsumablePanel.consumable = player_consumable_1
    %PlayerConsumables/ConsumablePanel.name_label.text = player_consumable_1.id
    %PlayerConsumables/ConsumablePanel.amount_label.text = str(player_consumable_1.amount)
    
    photon_consumable = Consumable.new("photons")
    photon_consumable.amount = 1000
    photon_consumable.min_amount = 0
    photon_consumable.max_amount = 1000
    photon_consumable.inventory_id = "None"
    photon_consumable.inventory_index = 0
    photon_consumable.connect("photons_updated", _on_photons_updated)
    %WorldConsumables/ConsumablePanel.consumable = photon_consumable
    %WorldConsumables/ConsumablePanel.amount_label.text = str(photon_consumable.amount)
    %WorldConsumables/ConsumablePanel.name_label.text = photon_consumable.id
    %WorldConsumables/ConsumablePanel.reciever = player_consumable_1
    

    consume_by_one = Consumer.new()
    consume_by_one.name = "consume_by_one"
    consume_by_one.is_auto = false
    consume_by_one.rate = 1
    %WorldConsumables/ConsumablePanel.consumer = consume_by_one
    %PlayerConsumables/ConsumablePanel.consumer = consume_by_one

