extends Node


export(int) var max_health =  1
onready var health = max_health setget  set_health# 游戏加载的时候再执行

signal no_health
func set_health(val):
	health = val
	print("Stats.gd  health=",health)
	if health<=0:
		emit_signal("no_health")


