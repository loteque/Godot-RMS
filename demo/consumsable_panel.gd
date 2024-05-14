extends PanelContainer

@export var name_label: Label
@export var amount_label: Label
@export var consume_button: Button
@export var consumer: Consumer


# defining this here feels wierd.
# this is defining a connection
# maybe connection[sender, reciever]
# or maybe define in consumer like:
# consumer.sender
# consumer.reciever

@export var consumable: Consumable
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
