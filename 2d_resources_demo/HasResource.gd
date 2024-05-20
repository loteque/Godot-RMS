extends Node

# this could be the product that the
# user interfaces with. It could be a
# custom node.

@onready var resource_container: ResourceContainer

@export var id: String
@export var amount: int
@export var min_amount: int
@export var max_amount: int
@export var depletable: bool = true

var parent

func _ready():
    resource_container = ResourceContainer.new(
        id, 
        amount, 
        min_amount, 
        max_amount
    )

func collect(collector):
    var collector_container = collector.inventory.get_container_by_name(
        resource_container.id
    )

    if collector_container:
        
        var transaction = Transaction.new(
            resource_container, 
            collector_container, 
            "add" + resource_container.id,
            resource_container.amount
        )

        transaction.execute()
    
    else:
        var new_container = ResourceContainer.new(
            "oxygen",
            0,
            0,
            100,
            collector.inventory.id,
            0
        )

        collector.inventory.add_container(
            new_container,
            0
        )

        var transaction = Transaction.new(
            resource_container, 
            new_container, 
            "add" + resource_container.id,
            resource_container.amount
        )

        transaction.execute()

    if depletable and resource_container.amount == 0:
        if parent:
            parent.queue_free()
    
