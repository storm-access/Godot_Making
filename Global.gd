extends Node

var EnemyHit = false

var block_y = []
var block_x = []
var Center:Vector2

var len_x = 23
var len_y = 17

@onready var BattleLevel = "res://Level/battle/level_battle.tscn"
@onready var GuildLevel = "res://Level/guild/a.tscn"
@onready var RewardLevel = "res://Level/reward/reward_screen.tscn"

var CameraLimit = [
	-1152,#left
	-109,#up
	1440,#right
	1184#bottom
]

var NowLevel
var isfirst = true
var isfirstCount = 0#説明を出さないための変数

var BattleTimer

var canEnter = false#決定ボタンを表示するかどうか

func get_positions(x:int,y:int):#Max(26,20)
	var block_matrix:Vector2
	var mat_x
	var mat_y
	mat_x = block_x[x]
	mat_y = block_y[y]
	block_matrix = mat_x+mat_y
	#print(block_matrix)
	return block_matrix

# Called when the node enters the scene tree for the first time.
func _ready():#Max(26,20)/Now(14,20)
	for y in len_y:
		block_y.append(Vector2(y * -48,y * 24))
	#y方向のベクターを配列に格納
	for x in len_x:
		block_x.append(Vector2(x * 48,x * 24))
	Center = get_positions(13,10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func LevelChange(level):
	if level == GuildLevel:
		isfirstCount += 1
		if isfirstCount >=2:
			isfirst = false
		Global.CameraLimit = [
			-1152,#left
			-109,#up
			1440,#right
			1184#bottom
		]
	get_tree().change_scene_to_file(level)
	NowLevel = level
	
	if level == BattleLevel:
		Global.CameraLimit = [
			-870,#left
			-110,#up
			1155,#right
			900#bottom
		]
