extends Area2D

var doesEnter = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if doesEnter == true:
		_GoBattle()
	pass


func _GoBattle():
	if Input.is_action_just_pressed("Enter"):
		Global.LevelChange(Global.BattleLevel)

func _on_body_shape_entered(_body_rid, body, body_shape_index, _local_shape_index):
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		doesEnter = true
		Global.canEnter = true

func _on_body_shape_exited(_body_rid, body, body_shape_index, _local_shape_index):
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		doesEnter = false
		Global.canEnter = false
