extends Node2D

var t = 0.0
var leper
var flag = 0

var areaDamage = false
var damage = 20

var doesEnter = false
var InBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	t += 2*_delta
	if flag == 0:
		leper = Vector2(255,0).lerp(Vector2(128,0),t)
		$Area2D/Polygon2D.modulate = Color8(int(leper.x),int(leper.x),int(leper.x),int(leper.x)-64)
		if leper.x <= 128.00:
			flag = 1
			t = 0
	elif flag == 1:
		leper = Vector2(128,0).lerp(Vector2(255,0),t)
		$Area2D/Polygon2D.modulate = Color8(int(leper.x),int(leper.x),int(leper.x),int(leper.x)-64)
		if leper.x >= 255:
			flag = 0
			t = 0
	if areaDamage == true:
		if doesEnter == true:
			if $Area2D.overlaps_body(InBody) == true:
				InBody.get_parent()._hurt(damage)
				doesEnter = false
				areaDamage = false


func _on_area_2d_body_entered(_body):#body全体を取得
	pass
	#if body.name == "body":
		#print("In")


func _on_area_2d_body_shape_entered(_body_rid, body, body_shape_index, _local_shape_index):#bodyの一部を取得
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		InBody = body
		doesEnter = true
	
