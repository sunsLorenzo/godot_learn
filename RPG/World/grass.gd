extends Node2D

#
#func _process(delta):
	#if Input.is_action_pressed("attack"):

func creat_grass_effect():
	var grassEffect = load("res://Effects/grassEffect.tscn").instance()
	
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position # global_position is the position of the grass
	queue_free()


func _on_Hurtbox_area_entered(area):
	creat_grass_effect()
	queue_free()
