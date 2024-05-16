extends Resource
class_name ResourceContainer

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var inventory_id: String
@export var inventory_index: int

enum STATUS {
    available,
    full,
    empty
}

var status: STATUS = STATUS.available
var transaction: Transaction
var full: bool = false
var empty: bool = false
var _updated_sig_str: String
var _remainder: int

func update_amount(new_amount: int):
    amount = new_amount
    emit_signal(_updated_sig_str, id, amount, _remainder)
    print("emitted container signal, new_amount: " + str(new_amount))

func subtract(rate):
    if status == STATUS.empty:
        return
    
    var new_amount = amount - rate
    if new_amount <= 0:
        new_amount = 0
        status = STATUS.empty
    else:
        status = STATUS.available

    update_amount(new_amount)

func add(rate):
    if status == STATUS.full:
        return

    var new_amount = amount + rate
    if new_amount >= max_amount:
        new_amount = max_amount
        status = STATUS.full
    else:
        status = STATUS.available

    update_amount(new_amount)

func get_status():
    return status

func get_signal_str():
    return _updated_sig_str

func _init(nam: String, 
            amt: int, 
            min_amt: int, 
            max_amt: int, 
            inv_id: String = "", 
            inv_idx: int = 0):
    
    id = nam
    amount = amt
    min_amount = min_amt
    max_amount = max_amt
    inventory_id = inv_id
    inventory_index = inv_idx

    _updated_sig_str = id + "_updated"
    add_user_signal(
        _updated_sig_str, 
        [       
            {"name": "id", "type": TYPE_STRING},
            {"name": "amount", "type": TYPE_INT}, 
            {"name": "_remainder", "type": TYPE_INT}
        ]
    )
