extends PanelContainer

@export var name_label: Label
@export var amount_label: Label
@export var consume_button: Button
@export var consumable_data: Node


func _on_consume_pressed():
    consumable_data.consumable.update_amount(
        consumable_data.consumer.consume(
            consumable_data.consumable
            )
        )

func _on_amount_updated(_name, amount):
    amount_label.text = str(amount)

func _ready():
    name_label.text = consumable_data.consumable.name
    amount_label.text = str(consumable_data.consumable.amount)
    consumable_data.consumable.amount_updated.connect(_on_amount_updated)


