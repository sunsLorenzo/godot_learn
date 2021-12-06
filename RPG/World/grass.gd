extends Node2D

#
#func _process(delta):
	#if Input.is_action_pressed("attack"):

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func creat_grass_effect():
	var grassEffect = GrassEffect.instance()
#	var world = get_tree().current_scene
#	world.add_child(grassEffect)
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position # global_position is the position of the grass
	queue_free()


func _on_Hurtbox_area_entered(area):
	creat_grass_effect()
	queue_free()
