extends Resource
class_name TransactionResource

var _id: String
var _rate: int
var _sender: ContainerResource
var _reciever: ContainerResource

enum ERROR{
    success,
    unknown,
    no_reciever,
    reciver_unavailable,
    no_sender,
    sender_unavailabe
}

func get_id():
    return _id

func get_rate():
    return _rate

func get_sender():
    return _sender

func get_reciever():
    return _reciever

func execute():
    #push_error("there was an execution error in transaction.execute()")
    if _reciever == null:

        return ERROR.no_reciever

    if _reciever.status == _reciever.STATUS.unavailable:

        return ERROR.reciver_unavailable

    if _sender.status == _sender.STATUS.unavailable:
        
        return ERROR.sender_unavailabe
    
    if _sender == _reciever:
        _sender.subtract(_rate)
        return ERROR.success

    if _sender != _reciever: 
        if _sender and _reciever:
            _sender.mode = _sender.MODE.sender
            _sender.subtract(_rate)
            _reciever.mode = _reciever.MODE.reciever
            _reciever.add(_rate)
            return ERROR.success

    return ERROR.unknown

func _init(sender: ContainerResource, 
            reciever: ContainerResource, 
            id: String = "",
            rate: int = 0
            ):

    _reciever = reciever
    _sender = sender
    _id = id
    _rate = rate
