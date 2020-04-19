extends Node

export var speed = 1000
onready var controlled : KinematicBody2D = get_parent()
	
func _process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("controller_up"): motion += Vector2(0,-1)
	if Input.is_action_pressed("controller_down"): motion += Vector2(0,1)
	if Input.is_action_pressed("controller_left"): motion += Vector2(-1,0)
	if Input.is_action_pressed("controller_right"): motion += Vector2(1,0)
	motion = motion.normalized()

	controlled.move_and_collide(motion * delta * speed)

