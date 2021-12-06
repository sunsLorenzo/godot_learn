extends Area2D

const HitEffct = preload("res://Effects/HitEffect.tscn")
export(bool) var show_effct = true
 
func _on_Hurtbox_area_entered(area):
	if show_effct:
		var hitEffect  = HitEffct.instance()
		var main = get_tree().current_scene
		main.add_child(hitEffect)
		hitEffect.global_position = global_position 
