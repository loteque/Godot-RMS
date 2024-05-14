extends PanelContainer

@export var name_label: Label
@export var amount_label: Label
@export var consume_button: Button
@export var consumable: Consumable
@export var consumer: Consumer
@export var reciever: Consumable

func _on_consume_pressed():
    consumable.update_amount(
        consumer.subtract(
            consumable
            )
        )
    if reciever:
        reciever.update_amount(
            consumer.add(
                reciever
            )
        )
