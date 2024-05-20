extends Resource
class_name Transaction

@export var name: String
@export var rate: int
@export var sender: ResourceContainer
@export var reciever: ResourceContainer

func execute():
    if !reciever:
        # we should return an error
        print("transaction " 
            + name + 
            " has no reciever"
            )
        return

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

func _init(send: ResourceContainer, 
            recieve: ResourceContainer, 
            nam: String = "", 
            r: int = 0
            ):

    reciever = recieve
    sender = send
    name = nam
    rate = r