extends Control

@onready var skill1 = $HBoxContainer/TextureButton
@onready var skill2 = $HBoxContainer/TextureButton2
@onready var skill3 = $HBoxContainer/TextureButton3

@onready var skillInfo = preload("res://UI/shop/Skill_Info.tscn")
var skillinfoInst

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_CT_Check()
	_ButtonChanged($HBoxContainer/TextureButton,PlayerStatus.skill1)
	_ButtonChanged($HBoxContainer/TextureButton2,PlayerStatus.skill2)
	_ButtonChanged($HBoxContainer/TextureButton3,PlayerStatus.skill3)
	

func _CT_Check():#CTの表示制御
	if PlayerInBattleStatus.can_use_skill1 == false:
		skill1.get_child(0).visible = true
		skill1.get_child(0).text = str("%.2f" % PlayerInBattleStatus.CT_Skill1.time_left)
		skill1.modulate = Color8(128,128,128,255)
	if PlayerInBattleStatus.can_use_skill1 == true:
		skill1.get_child(0).visible = false
		skill1.modulate = Color8(255,255,255,255)
	if PlayerInBattleStatus.can_use_skill2 == false:
		skill2.get_child(0).visible = true
		skill2.get_child(0).text = str("%.2f" % PlayerInBattleStatus.CT_Skill2.time_left)
		skill2.modulate = Color8(128,128,128,255)
	if PlayerInBattleStatus.can_use_skill2 == true:
		skill2.get_child(0).visible = false
		skill2.modulate = Color8(255,255,255,255)
	if PlayerInBattleStatus.can_use_skill3 == false:
		skill3.get_child(0).visible = true
		skill3.get_child(0).text = str("%.2f" % PlayerInBattleStatus.CT_Skill3.time_left)
		skill3.modulate = Color8(128,128,128,255)
	if PlayerInBattleStatus.can_use_skill3 == true:
		skill3.get_child(0).visible = false
		skill3.modulate = Color8(255,255,255,255)

func _ButtonCheck():#特に意味はない
	if skill1.is_hovered() == true:
		skill1.modulate = Color8(128,128,128,255)
	elif skill1.is_hovered() == false:
		skill1.modulate = Color8(255,255,255,255)


func _ButtonChanged(Buttons,SkillNum):#スキルによって表示画像を差し替え
	Buttons.texture_normal = load(SkillNum[10])
	Buttons.texture_pressed = load(SkillNum[10])
	Buttons.texture_hover = load(SkillNum[10])
	Buttons.texture_disabled = load(SkillNum[10])


func _on_texture_button_mouse_entered():#スキルにカーソルを合わせると情報を表示x3
	skillinfoInst = skillInfo.instantiate()
	get_node("../").add_child(skillinfoInst)
	skillinfoInst._SetText(PlayerStatus.skill1)


func _on_texture_button_mouse_exited():
	get_node("../").remove_child(skillinfoInst)
	skillinfoInst._delete()
	skillinfoInst.queue_free()


func _on_texture_button_2_mouse_entered():
	skillinfoInst = skillInfo.instantiate()
	get_node("../").add_child(skillinfoInst)
	skillinfoInst._SetText(PlayerStatus.skill2)

func _on_texture_button_2_mouse_exited():
	get_node("../").remove_child(skillinfoInst)
	skillinfoInst._delete()
	skillinfoInst.queue_free()


func _on_texture_button_3_mouse_entered():
	skillinfoInst = skillInfo.instantiate()
	get_node("../").add_child(skillinfoInst)
	skillinfoInst._SetText(PlayerStatus.skill3)


func _on_texture_button_3_mouse_exited():
	get_node("../").remove_child(skillinfoInst)
	skillinfoInst._delete()
	skillinfoInst.queue_free()
