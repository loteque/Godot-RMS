extends Resource
class_name ResourceContainer

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var inventory_id: String
@export var inventory_index: int

var transaction: Transaction
var _updated_sig_str: String
var _remainder: int
var _back_transaction: Transaction

func update_amount(new_amount: int):
    amount = new_amount
    emit_signal(_updated_sig_str, id, amount, _remainder)
    print("emitted container signal, new_amount: " + str(new_amount))

func subtract(rate):
    var new_amount = amount - rate
    
    if new_amount < min_amount:
        _remainder = min_amount - new_amount
        new_amount = min_amount

    update_amount(new_amount)

func add(rate):
    var new_amount = amount + rate

    if new_amount > max_amount:
        _remainder = new_amount - max_amount
        new_amount = max_amount
        
#back transaction not working        
        _back_transaction = Transaction.new(
            transaction.reciever, 
            transaction.sender,
            id + "_back_transaction",
            false,
            _remainder
        )
        _back_transaction.execute()

    update_amount(new_amount)

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
