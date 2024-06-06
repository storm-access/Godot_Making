extends Node

@onready var Eattacks = preload("res://About_Enemy/Enemy_Common/enemy_atks.tscn")
var EA

var _canuse = true
var _reserve = false

@onready var atkef = preload("res://About_Enemy/Enemy1/colider.tscn")
@onready var circles = preload("res://About_Enemy/Enemy1/for_4_circle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_SkillResrvation()
	pass

func _SkillResrvation():
	if _canuse == true:
		randomize()
		timeline()
		_canuse = false
	elif _canuse == false:
		if _reserve == true:
			if is_instance_valid(EA) == false:
				_canuse = true
				_reserve = false

func _atk(Number:int):
	match Number:
		1:
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Yline(20,2,randi_range(1,14),atkef)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Yline(20,2,randi_range(1,14),atkef)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Xline(20,2,randi_range(0,19),atkef)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Xline(20,2,randi_range(0,19),atkef)
		2:
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Circles(20,4,randi_range(4-1,20-4),randi_range(4-1,14-4),circles)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Circles(20,4,randi_range(4-1,20-4),randi_range(4-1,14-4),circles)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Circles(20,4,randi_range(4-1,20-4),randi_range(4-1,14-4),circles)
		3:
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Yline(20,2,randi_range(1,14),atkef)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Xline(20,2,randi_range(0,19),atkef)
			randomize()
			EA = Eattacks.instantiate()
			add_child(EA)
			EA._Circles(20,4,randi_range(4-1,20-4),randi_range(4-1,12-4),circles)


func timeline():#仮組
	randomize()
	var _time = randf_range(0.5,1.0)
	var _randtable = randi_range(1,3)
	await get_tree().create_timer(_time).timeout
	_reserve = true
	_atk(_randtable)
	randomize()
	_time = randf_range(0.5,1.0)
	_randtable = randi_range(1,3)
	await get_tree().create_timer(_time).timeout
	_reserve = true
	_atk(_randtable)
