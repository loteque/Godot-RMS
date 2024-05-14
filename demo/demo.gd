extends Control

var consume_by_one: Consumer
var photon_consumable: Consumable
var player_consumable_1: Consumable

func _on_wpc_amount_updated(_name, amount):
    %WorldConsumables/ConsumablePanel.amount_label.text = str(amount)

func _on_ppc_amount_updated(_name, amount):
    %PlayerConsumables/ConsumablePanel.amount_label.text = str(amount)

## need unique signals for each instance of consumable

func _ready():
    player_consumable_1 = Consumable.new()
    player_consumable_1.amount_updated.connect(_on_wpc_amount_updated)
    player_consumable_1.id = "player photons"
    player_consumable_1.amount = 0
    player_consumable_1.min_amount = 0
    player_consumable_1.max_amount = 1000
    player_consumable_1.inventory_id = "None"
    player_consumable_1.inventory_index = 0
    %PlayerConsumables/ConsumablePanel.name_label.text = player_consumable_1.id
    %PlayerConsumables/ConsumablePanel.amount_label.text = str(player_consumable_1.amount)
    
    photon_consumable = Consumable.new()
    photon_consumable.amount_updated.connect(_on_wpc_amount_updated)
    photon_consumable.id = "photons"
    photon_consumable.amount = 1000
    photon_consumable.min_amount = 0
    photon_consumable.max_amount = 1000
    photon_consumable.inventory_id = "None"
    photon_consumable.inventory_index = 0
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

