extends Area2D

var doesEnter = false

var isExist = false
@onready var shop = preload("res://UI/shop/shop_screen.tscn")
var shopInst
@onready var Nshop = preload("res://new_shop_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Enter"):
		if isExist == false:
			if doesEnter == true:
				_GoShop()
				pass
		elif isExist == true:
			if doesEnter == true:
				_ReShop()
				pass


func _GoShop():
	#if Input.is_action_just_pressed("Enter"):
		print("Shop")
		shopInst = Nshop.instantiate()
		$"../CanvasLayer".add_child(shopInst)
		isExist = true
		#shopInst.GetSkill()
		PlayerStatus.InShopNow = true
		#print($"../CanvasLayer".get_children())

func _ReShop():
	$"../CanvasLayer".add_child(shopInst)
	PlayerStatus.InShopNow = true
	#print($"../CanvasLayer".get_children())

func _Delete():
	shopInst._delete()


func _on_body_shape_entered(_body_rid, body, body_shape_index, _local_shape_index):
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		print(body_shape_index)
		doesEnter = true
		Global.canEnter = true


func _on_body_shape_exited(_body_rid, body, body_shape_index, _local_shape_index):
	if body.name == "Player_Body" &&  (body_shape_index == 0 || body_shape_index == 1):#足の判定だけ
		doesEnter = false
		Global.canEnter = false
