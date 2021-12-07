extends KinematicBody2D

const EnemyEffect = preload("res://Effects/EnemyDeathEffect.tscn")
enum{
	IDLE,
	WANDER,
	CHASE
}
export var ACCELARATION = 100
export var MAX_SPPED = 50
export var FRICTION = 400

var state = IDLE

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var sprite = $AnimatedBatSprite
onready var  stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox

func _ready():
	print(stats.max_health)
	print(stats.health)
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity =  velocity.move_toward(Vector2.ZERO, FRICTION*delta)
			seek_player()
		WANDER:
			velocity.x = rand_range(-1,1)
			velocity.y = rand_range(-1,1)
			velocity = velocity.normalized()*MAX_SPPED*0.3
#			velocity = velocity.move_toward(velocity*MAX_SPPED, ACCELARATION*delta)
			state=IDLE
		CHASE:
			var player = playerDetectionZone.player
			if player!=null:
				var direction = (player.global_position -global_position).normalized()
				velocity = velocity.move_toward(direction*MAX_SPPED, ACCELARATION*delta)
			else:
				state=WANDER
			sprite.flip_h = velocity.x<0
			
	velocity = move_and_slide(velocity)
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	else:
		state = WANDER
	
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
