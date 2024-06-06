extends Node2D

@onready var Eattacks = preload("res://About_Enemy/Enemy_Common/enemy_atks.tscn")
var EA

#var _canuse = true
#var _reserve = false

@onready var atkef = preload("res://About_Enemy/Enemy1/colider.tscn")
@onready var circles = preload("res://About_Enemy/Enemy1/for_4_circle.tscn")
@onready var Enemy= preload("res://About_Enemy/Enemy1/enemy.tscn")
#@onready var Enemy = $Enemy

var EnemySkill
var ESinst

var EnemyStats
var Enemys

var EnemyBody

var EnemySpawn = Vector2(224,304)
var PlayerSpawn = Vector2(-56,416)

# Called when the node enters the scene tree for the first time.
func _ready():
	EnemyStats = EnemySkillList.NextEnemyPush()
	EnemySkill = EnemyStats[2]
	EnemyStatus.HP = EnemyStats[1]
	EnemyStatus.MaxHP = EnemyStatus.HP
	EnemyStatus.Name = EnemyStats[0]
	$CanvasLayer/Enemy_HP/Label.text = EnemyStatus.Name
	EnemyStatus.Money = EnemyStats[3]
	$CanvasLayer/Enemy_HP.HPbar.max_value = EnemyStatus.MaxHP
	
	Enemys = Enemy.instantiate()
	EnemyBody = EnemyStats[4].instantiate()
	add_child(Enemys)
	Enemys.add_child(EnemyBody)
	
	Enemys.global_position = EnemySpawn
	$CanvasLayer/Enemy_HP.onFieldEnemy = Enemys
	
	ESinst = EnemySkill.instantiate()
	add_child(ESinst)
	Enemys.EnemyDeath.connect(_ESDelete)
	
	$player.global_position = PlayerSpawn


func _ESDelete():
	remove_child(ESinst)
	ESinst.queue_free()
	remove_child(Enemys)
	Enemys.queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():
	#Enemy.HP = 0
	randomize()
	EA = Eattacks.instantiate()
	add_child(EA)
	EA._Yline(20,2,randi_range(1,14),atkef)
	
	EA = Eattacks.instantiate()
	add_child(EA)
	EA._Xline(20,2,randi_range(0,19),atkef)
	
	EA = Eattacks.instantiate()
	add_child(EA)
	EA._Circles(20,4,randi_range(4-1,21-4),randi_range(4-1,15-4),circles)
	#print(get_children())
