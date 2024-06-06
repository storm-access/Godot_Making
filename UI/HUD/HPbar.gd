extends Control

var hpvalue#Hpの値
@onready var UniqueSkill = $TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hpvalue = PlayerStatus.PlayerHP
	$HPBar.max_value = PlayerStatus.PlayerMaxHP
	$HPBar.value = hpvalue
	$HBoxContainer/HP_value.text = str(hpvalue)
	$HBoxContainer/Max_HP.text = str(PlayerStatus.PlayerMaxHP)
	_hpvar_color()
	_CT_Check()

func _hpvar_color():#HP量に応じてバーの色を変化
	if float(1.0 * hpvalue/PlayerStatus.PlayerMaxHP) > 0.5:
		$HPBar.tint_progress = Color8(0,255,0,255)
	if float(1.0 * hpvalue/PlayerStatus.PlayerMaxHP) <= 0.5:
		$HPBar.tint_progress = Color8(255,255,0,255)
	if float(1.0 * hpvalue/PlayerStatus.PlayerMaxHP) <= 0.2:
		$HPBar.tint_progress = Color8(255,0,0,255)

func _CT_Check():#ユニークスキルのCT表示制御
	if PlayerInBattleStatus.can_use_Unique == false:
		UniqueSkill.get_child(0).visible = true
		UniqueSkill.get_child(0).text = str("%.2f" % PlayerInBattleStatus.CT_Unique.time_left)
		UniqueSkill.modulate = Color8(128,128,128,255)
	if PlayerInBattleStatus.can_use_Unique == true:
		UniqueSkill.get_child(0).visible = false
		UniqueSkill.modulate = Color8(255,255,255,255)

func _ButtonCheck():#現状意味はない
	if UniqueSkill.is_hovered() == true:
		UniqueSkill.modulate = Color8(128,128,128,255)
	elif UniqueSkill.is_hovered() == false:
		UniqueSkill.modulate = Color8(255,255,255,255)
