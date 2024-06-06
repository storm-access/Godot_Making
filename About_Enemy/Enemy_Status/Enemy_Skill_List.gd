extends Node

@onready var Enemy1 = preload("res://About_Enemy/Enemy1/enemy_body_1.tscn")
@onready var Enemy1_Skill = preload("res://About_Enemy/Enemy1/enemy_skill_1.tscn")
@onready var Enemy2 = preload("res://About_Enemy/Enemy2/enemy_body_2.tscn")
@onready var Enemy2_Skill = preload("res://About_Enemy/Enemy2/enemy_skill_2.tscn")

var NextEnemy
var SkillLists

var EnemyNumber = 0

var EnemyNames = [
	"Enemy1","Enemy2"
]

# Called when the node enters the scene tree for the first time.
#Name,HP,skiill.Money
func _ready():
	SkillLists = {
		"Enemy1":["Enemy1",100,Enemy1_Skill,50,Enemy1],
		"Enemy2":["Enemy1",200,Enemy2_Skill,75,Enemy2],
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func NextEnemyPush():
	var pushEnemy
	pushEnemy = SkillLists.get(EnemyNames[EnemyNumber]).duplicate()
	EnemyNumber += 1
	if EnemyNumber > 1:
		EnemyNumber = 0
	return pushEnemy
