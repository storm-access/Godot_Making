extends Node2D

@onready var skillgeter = preload("res://UI/reward/skill_get.tscn")
var getskill

# Called when the node enters the scene tree for the first time.
func _ready():
	GetSkill()
	$Label.text = "Time : " + str(Global.BattleTimer) + "s"
	$Label2.text = "Gold : " + str(EnemyStatus.Money) + "G"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func GetSkill():
	getskill = skillgeter.instantiate()
	$CanvasLayer.add_child(getskill)
	getskill.SetText(SkillList._hacsla("shot","Lv4"))


func _on_button_button_up():
	Global.LevelChange(Global.GuildLevel)
	pass # Replace with function body.
