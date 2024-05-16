extends Resource
class_name Transaction

@export var name: String
@export var is_auto: bool
@export var rate: int
@export var sender: ResourceContainer
@export var reciever: ResourceContainer

func execute():
    if sender == reciever:
        sender.subtract(rate)
    elif reciever.status == reciever.STATUS.full:
        return

    if sender.status == sender.STATUS.empty:
        return
    
    if sender != reciever: 
        if sender:
            sender.subtract(rate)
    
        if reciever:
            reciever.add(rate)

func _init(send: ResourceContainer, recieve: ResourceContainer, nam: String = "", auto: bool = false, r: int = 0):
    reciever = recieve
    sender = send
    name = nam
    is_auto = auto
    rate = r