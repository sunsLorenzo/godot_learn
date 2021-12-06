extends KinematicBody2D

const EnemyEffect = preload("res://Effects/EnemyDeathEffect.tscn")

var knockback = Vector2.ZERO
onready var  stats = $Stats


func _ready():
	print(stats.max_health)
	print(stats.health)
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
#	if stats.health <= 0:
#		queue_free()
	knockback = area.knockback_vector * 150  # area 是进入该物体的area (Player 的Hitbox ) 

func create_death_animation():
	pass

	var enemyDeathEffect = EnemyEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	queue_free()
func _on_Stats_no_health():
	create_death_animation()
	queue_free()
