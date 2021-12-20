extends Camera2D

onready var topLeft = $limits/topLeft
onready var bottumRight = $limits/bottumRight


func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	
	limit_bottom = bottumRight.position.y
	limit_right = bottumRight.position.x
	
