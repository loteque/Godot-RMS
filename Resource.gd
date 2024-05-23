extends Node
class_name ResourceContainer

@export var parent: Node
@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var depletable: bool = true

var container: ContainerResource
var transaction_exit_status: int

signal created_container(container: ContainerResource)
signal attached_container(attached_to: ResourceContainer)
signal removed_container(removed_from: ResourceContainer)
signal updated_container(id: String, amount: int, inventory_name: String)
signal transaction_executed(transaction: TransactionResource, exit_status)

func get_container():
    return container

func create_container(
    con_nam: String, 
    con_amt: int, 
    con_min_amt: int, 
    con_max_amt: int, 
    inv_id: String = "", 
    inv_idx: int = 0
    ):

    container = ContainerResource.new(
        con_nam, 
        con_amt, 
        con_min_amt, 
        con_max_amt, 
        inv_id, 
        inv_idx
        )

    created_container.emit(container)
    attached_container.emit(self)

func attach_container(container_):
    container = container_
    attached_container.emit()

func _execute_transaction(transaction):
    var err = transaction.execute()
    transaction_executed.emit(transaction, err)
    if err == transaction.ERROR.success:
        updated_container.emit(
            transaction.get_reciever().get_id(), 
            transaction.get_reciever().get_amount(),
            transaction.get_reciever().get_inventory_id()
        )

func send_update_to_inventory(reciever: Inventory):
    var reciever_container = reciever.get_inventory().get_container_by_name(
        container.get_id()
    )

    if reciever_container:
        
        var transaction = TransactionResource.new(
            container, 
            reciever_container, 
            "add" + container.get_id(),
            container.get_amount()
        )

        _execute_transaction(transaction)
    
    else:
        var new_container = ContainerResource.new(
            container.get_id(),
            0,
            0,
            reciever.get_inventory().get_container_max_size(),
            reciever.get_inventory().get_id(),
            0
        )
        print("container id: " + str(new_container.get_id()))
        print("container max: " + str(new_container.get_max_amount()))
        print("inventory container max: " + str(reciever.get_inventory().get_container_max_size()))

        reciever.add_container(
            new_container,
            0
        )

        var transaction = TransactionResource.new(
            container, 
            new_container, 
            "add" + str(container.get_amount()) + container.get_id(),
            container.get_amount()
        )
        print(str(transaction.get_sender(), transaction.get_reciever(), transaction.get_rate()))
        _execute_transaction(transaction)

    if depletable and container.get_amount() == 0:
        removed_container.emit()
        parent.queue_free()


func _ready():
    create_container(
        id, 
        amount, 
        min_amount, 
        max_amount
    )
