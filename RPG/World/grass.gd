extends Node2D


func _process(delta):
	if Input.is_action_pressed("attack"):
		var grassEffect = load("res://Effects/grassEffect.tscn").instance()
		
		var world = get_tree().current_scene
		world.add_child(grassEffect)
		grassEffect.global_position = global_position # global_position is the position of the grass
		queue_free()
