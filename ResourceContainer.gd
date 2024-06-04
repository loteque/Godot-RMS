#We need to rename a lot of things in this file
extends Node
class_name ResourceContainer

@export var parent: Node
@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var depletable: bool = true
    # TODO: #11 User should be able to use a resource to store preconfigured values for a resource item and pass the resource to init 
@export var resource: Resource

var store: Store
var transaction_exit_status: int

signal created_store(container: Store)
signal attached_store(attached_to: ResourceContainer)
signal removed_resource_container(removed_from: Node)
signal updated_store(
    id: String, 
    amount: int, 
    inventory_name: String, 
)
signal transaction_executed(
    transaction: Transaction, 
    exit_status: Transaction.ExitStatus
)

func get_store():
    return store

func create_store():

    store = Store.new(
        id, 
        amount, 
        min_amount, 
        max_amount,
        depletable, 
        "", 
        0
        )

    created_store.emit(store)
    attached_store.emit(self)

func attach_store(new_store):
    store = new_store
    attached_store.emit()

func _execute_transaction(transaction: Transaction) -> Transaction.ExitStatus:
    var exit_status = transaction.execute()
    transaction_executed.emit(transaction, exit_status)
    if exit_status.get_error() == transaction.ERROR.success:
        updated_store.emit(
            transaction.get_reciever().get_id(), 
            transaction.get_reciever().get_amount(),
            transaction.get_reciever().get_inventory_id()
        )
        updated_store.emit(
            transaction.get_sender().get_id(),
            transaction.get_sender().get_amount(),
            transaction.get_sender().get_inventory_id()
        )

    return exit_status

func send_update_to_inventory(target_inventory: Inventory):
    
    #TODO: #16 ResourceContainer::send_update_to_inventory() should push_info exit_status in debug builds and editor mode
    var exit_status: Transaction.ExitStatus
    var reciever_store = (
        target_inventory
        .get_metastore()
        .get_store_by_name(
            store.get_id()
        )
    )

    var metastore_status = (
        target_inventory
        .get_metastore()
        .get_status()
    )    
    var metastore_store_max_size = (
        target_inventory
        .get_metastore()
        .get_store_max_size()
    )
    var metastore_last_index = (
        target_inventory
        .get_metastore()
        .get_stores()
        .size()
    )
    var new_metastore_index = metastore_last_index + 1 
   
    var store_id = store.get_id()
    var transaction_amount = store.get_amount()
    var transaction_id = (
        "add" 
        + str(transaction_amount) 
        + str(store_id)
    )
    var metastore_id = (
        target_inventory
        .get_metastore()
        .get_id()
    )
    var new_store = Store.new(
        store_id,
        0,
        metastore_last_index,
        metastore_store_max_size,
        true,
        metastore_id,
        new_metastore_index,
    )

    if metastore_status == Metastore.STATUS.unavailable:

        exit_status = Transaction.ExitStatus.new()
        exit_status.set_status(Transaction.ERROR.reciver_unavailable, 0)
        
        return exit_status

    if reciever_store:
        
        var transaction = Transaction.new(
            store, 
            reciever_store, 
            transaction_id,
            transaction_amount
        )
        exit_status = _execute_transaction(transaction)
    
    else:

        target_inventory.add_store(
            new_store,
        )

        var transaction = Transaction.new(
            store, 
            new_store, 
            transaction_id,
            transaction_amount
        )
        exit_status = _execute_transaction(transaction)


    if store.is_depleted():
        removed_resource_container.emit(get_parent())
        queue_free()


func _ready():
    create_store()
    parent = get_parent()
