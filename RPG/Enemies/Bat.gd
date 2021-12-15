extends KinematicBody2D

const EnemyEffect = preload("res://Effects/EnemyDeathEffect.tscn")
enum{
	IDLE,
	WANDER,
	CHASE
}
export var ACCELARATION = 200
export var MAX_SPPED = 50
export var FRICTION = 400

var state = IDLE

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var sprite = $AnimatedBatSprite
onready var  stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController


func _ready():
	randomize()
	print(stats.max_health)
	print(stats.health)
	update_wander()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity =  velocity.move_toward(Vector2.ZERO, FRICTION)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			
		WANDER:
			seek_player()
#			wanderController.update_target_position()
			if wanderController.get_time_left() == 0:
				update_wander()
#				wanderController.update_target_position()
			accelerate_towards( wanderController.target_position, delta)
			#新的wander state
#			if global_position.distance_to(wanderController.target_position)<=1:
#				update_wander()
		
		CHASE:
			var player = playerDetectionZone.player
			if player!=null:
#				var direction = (player.global_position -global_position).normalized()
				accelerate_towards( player.global_position, delta)
			else:
				state=IDLE
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector()*delta*MAX_SPPED*3
		 
	velocity = move_and_slide(velocity)
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	else:
		state = WANDER
func update_wander():
	state = pick_random_state([IDLE,WANDER])
	wanderController.set_wander_timer(rand_range(1,3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func accelerate_towards( point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction*MAX_SPPED, ACCELARATION*delta)
	sprite.flip_h = velocity.x<0
	
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
#	if stats.health <= 0:
#		queue_free()
	hurtbox.create_hit_effect()
	knockback = area.knockback_vector * 150  # area 是进入该物体的area (Player 的Hitbox ) 
	
	
func create_death_animation():
	var enemyDeathEffect = EnemyEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	queue_free()

func _on_Stats_no_health():
	create_death_animation()
	queue_free()
