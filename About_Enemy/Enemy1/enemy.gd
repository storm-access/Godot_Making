extends Node2D

var HP = 100
var deathchecker

signal EnemyDeath

var ToDeathTime = 0.0


var x
var t = 0.0
var move_switch = false
var beforeX

var HighOrLow = true
var Stopping = true

# Called when the node enters the scene tree for the first time.
func _ready():
	deathchecker = false
	Global.BattleTimer = 0.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	ToDeathTime += _delta
	if deathchecker == false:
		_randmove(_delta)
		if HP <= 0:
			deathchecker = true
			Global.LevelChange(Global.GuildLevel)
			Global.BattleTimer = snappedf(ToDeathTime,0.01)
			_death()
	#elif HP > 0:
		#HasSkill._SkillResrvation()

func _randmove(deltatime):
	#lerp呼び出し
	if move_switch == true:
		t += deltatime * 0.5
		var setposi = Global.get_positions(x,3)
		global_position = global_position.lerp(setposi,t)
		if t >= 1.0:
			move_switch = false#移動終了通知
			Stopping = true
	elif move_switch == false:
		if Stopping:
			Stopping = false
			await get_tree().create_timer(1.0).timeout
			randomize()
			if HighOrLow:
				HighOrLow = false
				x = randi_range(0,8)
			else:
				HighOrLow = true
				x = randi_range(9,18)
			print(HighOrLow)
			t = 0.0
			move_switch = true


func _death():
	EnemyDeath.emit()

func _hurt():
	HP = EnemyStatus.HP

