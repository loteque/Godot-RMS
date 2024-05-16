extends PanelContainer

@export var name_label: Label
@export var amount_label: Label
@export var consume_button: Button

var container: ResourceContainer

func create_container(
    con_nam: String, 
    con_amt: int, 
    con_min_amt: int, 
    con_max_amt: int, 
    inv_id: String = "", 
    inv_idx: int = 0
    ):

    container = ResourceContainer.new(
        con_nam, 
        con_amt, 
        con_min_amt, 
        con_max_amt, 
        inv_id, 
        inv_idx
        )

    name_label.text = con_nam
    amount_label.text = str(con_amt)
    name = con_nam

    var sig_str = container.get_signal_str()
    container.connect(sig_str, _on_updated)

    return self

func _on_updated(transaction_name, amount):
    amount_label.text = str(amount)
    print("caught container signal from: " 
    + transaction_name + 
    ", amount: " 
    + str(amount) + 
    ", with remainder: ")

func _on_consume_pressed():
    container.transaction.execute()
    print("_on_consume_pressed")
