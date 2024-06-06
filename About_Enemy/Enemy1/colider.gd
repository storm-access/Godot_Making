extends Node2D

@onready var Php = preload("res://About_Player/Player_Body/player.tscn")
var damage = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_shape_entered(_body_rid, body, body_shape_index, _local_shape_index):
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		print("hit!")
		body.get_parent()._hurt(damage)
