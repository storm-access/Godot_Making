extends Node2D

@onready var camera = $Camera2D
var NowDirection:String

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.limit_left = Global.CameraLimit[0]
	camera.limit_top = Global.CameraLimit[1]
	camera.limit_right = Global.CameraLimit[2]
	camera.limit_bottom = Global.CameraLimit[3]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.global_position = $Player_Body.global_position
	if Global.canEnter:
		$Player_Body/EnterButton.visible = true
	else:
		$Player_Body/EnterButton.visible = false
	pass
