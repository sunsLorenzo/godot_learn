extends KinematicBody2D

export var ACCELLERATION = 400
export var MAX_SPEED = 50
export var FRICTION = 800

enum {
	MOVE,
	ROLL,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN


onready var  animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox


func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector!= Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector 
		
		animationTree.set("parameters/Idel/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector) 
		animationTree.set("parameters/Roll/blend_position", input_vector) 
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACCELLERATION)
	else:
		animationState.travel("Idel")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
#	move_and_collide(velocity)
	move(velocity)
	if Input.is_action_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL
		
func attack_state(delta):
	velocity = Vector2.ZERO
	
	animationState.travel("Attack")
	
func roll_state(delta):
	velocity = MAX_SPEED * roll_vector * 1.25
	animationState.travel("Roll")
	move(velocity)
	
func move(velocity):
	move_and_slide(velocity)

func roll_animation_finished():
	state = MOVE

func attack_animation_finished():
	state = MOVE
	
