extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "Enemy_Body":#足の判定だけ
		#print("ToEnemyHit")
		Global.EnemyHit = true


func _on_area_2d_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "Enemy_Body":#足の判定だけ
		#print("Avoid")
		Global.EnemyHit = false

func _delete():
	Global.EnemyHit = false
