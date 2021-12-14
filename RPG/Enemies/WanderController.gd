extends Node2D

export(int) var wander_range = 32
onready var start_posititon = global_position
onready var target_position = global_position
onready var timer = $Timer

func _on_Timer_timeout():
	update_target_position()
	
func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range,wander_range), rand_range(-wander_range,wander_range))
	target_position = start_posititon+target_position
func get_time_left():
	return timer.time_left
