extends RigidBody2D

@export var resource: Node

func _on_area_2d_area_entered(area:Area2D):
    resource.parent = self
    if area.get_parent().is_in_group("Collectors"):
        resource.collect(area.get_parent())
