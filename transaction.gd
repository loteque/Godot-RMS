extends Resource
class_name Transaction

var _id: String
var _rate: int
var _sender: Store
var _reciever: Store

enum ERROR{
    success,
    unknown,
    no_reciever,
    reciver_unavailable,
    no_sender,
    sender_unavailabe
}

class ExitStatus:
    var _error: ERROR = ERROR.unknown 
    var _overflow: int = 0
    func set_status(error: ERROR, overflow: int):
        _error = error
        _overflow = overflow
    func get_error() -> int:
        return _error
    func get_overflow() -> int:
        return _overflow

func get_id():
    return _id

func get_rate():
    return _rate

func get_sender():
    return _sender

func get_reciever():
    return _reciever

func execute() -> ExitStatus:
    
    var exit_status = ExitStatus.new()
    
    if _reciever == null:
        
        exit_status.set_status(ERROR.no_reciever, 0)

    if _reciever.status == _reciever.STATUS.unavailable:

        exit_status.set_status(
            ERROR.reciver_unavailable, 
            0
        )

    if _sender.status == _sender.STATUS.unavailable:
        
        exit_status.set_status(
            ERROR.sender_unavailabe, 
            0
        )
    
    if _sender == _reciever:
        
        _sender.subtract(_rate)
        exit_status.set_status(ERROR.success, 0)

    if _sender != _reciever: 
        
        if _sender and _reciever:
            _sender.mode = _sender.MODE.sender
            _sender.subtract(_rate)
            _reciever.mode = _reciever.MODE.reciever
            var overflow = (
                _reciever
                .claculate_overflow(_rate)
            )
            _reciever.add(_rate)
            exit_status.set_status(
                ERROR.success, 
                overflow
            )
    
    # TODO: #12 exit_status erros should only be returned in editormode and debug buiilds
    if exit_status.get_error() != ERROR.success:
        push_warning(
            "transaction.execute(), 
            error code: " 
            + str(exit_status.get_error())
        )
    
    return exit_status

func _init(sender: Store, 
            reciever: Store, 
            id: String = "",
            rate: int = 0
            ):

    _reciever = reciever
    _sender = sender
    _id = id
    _rate = rate
