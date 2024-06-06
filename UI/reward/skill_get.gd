extends Control

signal defuse
#@onready var skillchange = preload("res://Skill_Change.tscn")
var SkillDatas

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func SetText(SkillData):
	$VBoxContainer/Damage.text = "Damage : " + str(SkillData[1])
	_ColorChange(0,$VBoxContainer/Damage)
	$VBoxContainer/Activation.text = "Activation : " + str(SkillData[2]) +"s"
	_ColorChange(1,$VBoxContainer/Activation)
	$VBoxContainer/CT.text = "CoolTime : " + str(SkillData[3]) +"s"
	_ColorChange(2,$VBoxContainer/CT)
	$VBoxContainer/HP.text = "HP : +" + str(SkillData[7])
	$VBoxContainer/ATK.text = "ATK : +" + str(SkillData[8])
	$Explain.text = str(SkillData[9])
	$TextureRect.texture = load(SkillData[10])
	SkillDatas = SkillData

func _ColorChange(Index,Text):
	#print(SkillList.ColorSet[Index])
	if SkillList.ColorSet[Index] == "equal":
		Text.label_settings.font_color = Color8(256,256,256,256)
	if SkillList.ColorSet[Index] == "plus":
		Text.label_settings.font_color = Color8(0,128,256,256)
	if SkillList.ColorSet[Index] == "minus":
		Text.label_settings.font_color = Color8(256,0,0,256)



func _on_get_skill_1_pressed():
	PlayerStatus.skill1 = SkillDatas
	PlayerStatus._statusSet()
	get_node("../").remove_child(self)
	queue_free()

func _on_get_skill_2_button_up():
	PlayerStatus.skill2 = SkillDatas
	PlayerStatus._statusSet()
	get_node("../").remove_child(self)
	queue_free()


func _on_ignore_skill_button_up():
	get_node("../").remove_child(self)
	queue_free()

