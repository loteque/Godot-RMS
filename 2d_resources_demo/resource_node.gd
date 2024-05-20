extends RigidBody2D

#this is representative of a user script 
#it should make calls to the lib
#at the surfaces and not use directly
#logic from the library. 

# I like how this script is only concerned 
# with game logic and is not concerned with
# managing inventory and resource logic.

@export var resource: Node

func _on_area_2d_area_entered(area:Area2D):
    resource.parent = self
    if area.get_parent().is_in_group("Collectors"):
        resource.collect(area.get_parent())
