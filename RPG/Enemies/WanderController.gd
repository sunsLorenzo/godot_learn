extends Node2D

export(int) var wander_range = 32
onready var start_posititon = global_position
onready var target_position = global_position+Vector2(rand_range(-wander_range,wander_range), rand_range(-wander_range,wander_range))
onready var timer = $Timer

func _on_Timer_timeout():
	update_target_position()
#	print(target_position)


func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range,wander_range), rand_range(-wander_range,wander_range))
	target_position = start_posititon + target_vector
#	start_posititon = global_position


func set_wander_timer(duration):
	timer.start(duration)
#	print('set', duration)


func get_time_left():
	return timer.time_left
