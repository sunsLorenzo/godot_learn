extends KinematicBody2D

const ACCELLERATION = 400
const MAX_SPEED = 100
const FRICTION = 800

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector!= Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACCELLERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
#	move_and_collide(velocity)
	move_and_slide(velocity)