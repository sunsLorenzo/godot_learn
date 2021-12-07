extends Node


export(int) var max_health =  1 setget set_max_health
var health = max_health setget  set_health# 游戏加载的时候再执行

signal no_health
signal health_changed
signal max_health_changed

func set_max_health(val):
	max_health = val
	self.health = min(health, max_health)
	emit_signal("max_health_changed", val)

func set_health(val):
	health = val
#	print("Stats.gd  health=",health)
	emit_signal("health_changed",val)  # 带参数signal
	if health<=0:
		emit_signal("no_health")

func _ready():
	self.health = max_health
	
