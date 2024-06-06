extends Node2D

@onready var shop = preload("res://UI/shop/shop_screen.tscn")
var shopInst

@onready var Transition = preload("res://transition.tscn")
var TransitionInstance

@onready var Explain = preload("res://explain.tscn")
var ExplainInst
#var isfirst = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#if Global.isfirst == false:
		#GetSkill()
	#$AudioStreamPlayer2D.play()
	if Global.isfirst == true:
		PlayerStatus.InShopNow = true
		TransitionInstance = Transition.instantiate()
		$CanvasLayer.add_child(TransitionInstance)
		TransitionInstance.transitionEnd.connect(_Remove)
		TransitionInstance.fade_value = 0.0
		TransitionInstance.IsFadeOut = true#トランジション開始のスイッチ
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _Remove():
	$CanvasLayer.remove_child(TransitionInstance)
	TransitionInstance.queue_free()
	
	ExplainInst = Explain.instantiate()
	$CanvasLayer.add_child(ExplainInst)


