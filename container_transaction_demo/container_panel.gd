extends PanelContainer

#this is representative of a user script 
#it should make calls to the lib
#at the surfaces and not use directly
#logic from the library. 

@export var name_label: Label
@export var amount_label: Label
@export var consume_button: Button

var container: ResourceContainer

#this should probably belong to HasResource. 
#It looks like api for the resource management lib
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

#this also looks like api for Res Management code
func add_container(container_):
    container = container_
    name_label.text = container.id
    amount_label.text = str(container.amount)
    name = container.id

    var sig_str = container.get_signal_str()
    container.connect(sig_str, _on_updated)

func _on_updated(_transaction_name, amount):
    amount_label.text = str(amount)


func _on_consume_pressed():
    container.transaction.execute()
    print("_on_consume_pressed")
