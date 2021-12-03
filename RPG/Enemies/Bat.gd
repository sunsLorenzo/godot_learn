extends KinematicBody2D

var knockback = Vector2.ZERO
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 300*delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * 150  # area 是进入该物体的area (Player 的Hitbox ) 
#	queue_free()
