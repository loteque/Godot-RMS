extends Resource
class_name Store

var _id: String
var _amount: int
var _min_amount: int
var _max_amount: int
var _metastore_id: String
var _metastore_index: int
var _is_depletable: bool = true

enum STATUS {
    available,
    unavailable
}

enum STATE{
    unknown,
    partial,
    full,
    empty
}

enum MODE {
    sender,
    reciever,
    neutral
}

var status: STATUS = STATUS.available
var state: STATE = STATE.unknown
var mode: MODE = MODE.neutral

func get_id():
    return _id

func get_amount():
    return _amount

func get_min_amount():
    return _min_amount

func get_max_amount():
    return _max_amount

func get_inventory_id():
    return _metastore_id

func get_inventory_index():
    return _metastore_index

func get_status():
    return status

func get_state():
    return state

func get_mode():
    return mode

func claculate_overflow(rate: int) -> int:
    var new_amount = _amount + rate
    var overflow: int = 0
    
    if new_amount > _max_amount:
        overflow = new_amount - _max_amount

    return overflow

func update_amount(new_amount: int):
    _amount = new_amount

func is_depleted():
    if _is_depletable and state == STATE.empty:
        return true
    else:
        return false

func subtract(rate):
    if state == STATE.empty:
        status = STATUS.unavailable
        return
    
    var new_amount = _amount - rate
    if new_amount <= 0:
        new_amount = 0
        state = STATE.empty
        status = STATUS.unavailable
    else:
        state = STATE.partial
        status = STATUS.available

    update_amount(new_amount)

func add(rate):
    if state == STATE.full:
        status = STATUS.unavailable
        return

    var new_amount = _amount + rate
    if new_amount >= _max_amount:
        new_amount = _max_amount
        state = STATE.full
        status = STATUS.unavailable

    else:
        state = STATE.partial
        status = STATUS.available

    update_amount(new_amount)



func _init(name: String, 
            amount: int, 
            min_amount: int, 
            max_amount: int, 
            is_depletable,
            metastore_id: String = "", 
            metastore_index: int = 0
            ):
    
    _id = name
    _amount = amount
    _min_amount = min_amount
    _max_amount = max_amount
    _is_depletable = is_depletable
    _metastore_id = metastore_id
    _metastore_index = metastore_index

func _ready():
    status = STATUS.available
