extends Area2D

const HitEffct = preload("res://Effects/HitEffect.tscn")
onready var timer = $Timer
var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

func set_invincible(val):
	invincible = val 
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	
func create_hit_effect():
	var hitEffect  = HitEffct.instance()
	var main = get_tree().current_scene
	main.add_child(hitEffect)
	hitEffect.global_position = global_position 

func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_started():
#	monitorable = false
	set_deferred("monitorable", false)
	

func _on_Hurtbox_invincibility_ended():
	monitorable = true
#	set_deferred("moniterable", true)
