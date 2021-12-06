extends AnimatedSprite



func _ready():
	connect("animation_finished", self, "_on_AnimatedSprite_animation_finished") 
	# 连接到 animation-finished信号之后会自动连接 信号 激活目标函数
	frame =  0 
	play("Animate")

func _on_AnimatedSprite_animation_finished():
	queue_free()
