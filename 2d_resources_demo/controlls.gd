extends Node

var player

var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	player.move_and_slide()