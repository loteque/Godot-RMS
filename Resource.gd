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

func create_container():

    container = ContainerResource.new(
        id, 
        amount, 
        min_amount, 
        max_amount,
        depletable, 
        "", 
        0
        )

    created_container.emit(container)
    attached_container.emit(self)

func attach_container(container_):
    container = container_
    attached_container.emit()

func _execute_transaction(transaction: TransactionResource) -> int:
    var err = transaction.execute()
    transaction_executed.emit(transaction, err)
    if err == transaction.ERROR.success:
        updated_container.emit(
            transaction.get_reciever().get_id(), 
            transaction.get_reciever().get_amount(),
            transaction.get_reciever().get_inventory_id()
        )

    return err

func send_update_to_inventory(reciever_inventory: Inventory):
    var reciever_container = reciever_inventory.get_inventory().get_container_by_name(
        container.get_id()
    )

    if reciever_container:

        #debug
        print("reciever_container: " + str(reciever_container))
        print("reciever_inventory container id: " + str(reciever_container.get_id()))
        print("reciever_inventory container max: " + str(reciever_container.get_max_amount()))
        print("inventory container max: " + str(reciever_inventory.get_inventory().get_container_max_size()))
        
        var transaction = TransactionResource.new(
            container, 
            reciever_container, 
            "add" + container.get_id(),
            container.get_amount()
        )
        
        #await get_tree().create_timer(1).timeout


        var err = _execute_transaction(transaction)
        print("transaction error code: " + str(err))
    
    else:
        var new_container = ContainerResource.new(
            container.get_id(),
            0,
            0,
            reciever_inventory.get_inventory().get_container_max_size(),
            true,
            reciever_inventory.get_inventory().get_id(),
            0,
        )
        
        #debug
        print("container id: " + str(new_container.get_id()))
        print("container max: " + str(new_container.get_max_amount()))
        print("inventory container max: " + str(reciever_inventory.get_inventory().get_container_max_size()))

        reciever_inventory.add_container(
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
        
        var err = _execute_transaction(transaction)
        print("transaction error code: " + str(err))

    if container.is_depleted():
        removed_container.emit(self)
        queue_free()


func _ready():
    create_container()
