extends Node

var PlayerHP = 100
var PlayerMaxHP = 100
var HPdefo = 100
var atk = 0

var HasMoney = 10

var skill1
var skill2
var skill3
#PlayerStatus.skill1 = SkillList.shot#仮で技を配置
#PlayerStatus.skill2 = SkillList.slash#仮で技を配置

var InShopNow = false#今の処理だとこっちが下の役割
var CanMoving = false#移動させたくない時のフラグ?

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStatus.skill1 = SkillList._hacsla("shot","Lv1")
	PlayerStatus.skill2 = SkillList._hacsla("slash","Lv1")
	PlayerStatus.skill3 = SkillList._hacsla("explo","Lv1")
	#print(PlayerStatus.skill1)
	#print(PlayerStatus.skill2)
	PlayerStatus._statusSet()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _statusSet():
	var beforeMax = PlayerMaxHP
	PlayerMaxHP = HPdefo
	atk = 0
	PlayerMaxHP += (skill1[7] + skill2[7]) 
	
	if beforeMax >= PlayerMaxHP:#最大値が小さくなった時
		if PlayerHP >= PlayerMaxHP:
			PlayerHP = PlayerMaxHP
		atk += (skill1[8] + skill2[8])
	
	elif beforeMax < PlayerMaxHP:#大きくなった時
		var diff = PlayerMaxHP - beforeMax
		PlayerHP += diff
		if PlayerHP > PlayerMaxHP:
			PlayerHP = PlayerMaxHP
		atk += (skill1[8] + skill2[8])
