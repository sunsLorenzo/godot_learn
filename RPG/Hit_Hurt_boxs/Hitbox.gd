extends Area2D


export var damage = 1
onready var collision = $CollisionShape2D

func disable_hit():
	collision.set_deferred("disabled", true)
func enable_hit():
	collision.set_deferred("disabled", false)
