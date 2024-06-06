extends Node

@onready var Pshot = preload("res://About_Player/Player_Skill/player_slash.tscn")#中距離
@onready var Pslash = preload("res://About_Player/Player_Skill/player_buturi.tscn")#近距離
@onready var explo = preload("res://About_Player/Player_Skill/player_explo.tscn")#

#飛び道具タイプは敵に到着時にダメージ
#威力、詠唱時間、CT、x距離(奇数)、y距離、スプライト
#直接タイプはモーション完了後にダメージ
#威力、詠唱時間、CT、x距離(奇数)、y距離、スプライト
var skilldict#スキル格納辞書
var uniquedict#ユニークスキル

var shot#スキル1
var slash#スキル2

#Level:[damage,chargeTime,CoolTime,HP,ATK]
var RevisonLevel

var IsLight = false
var IsLight2 = false
var skilldata
var beforeSkillData
var ColorSet:Array = []

var ToshopMultColor = []


var SkillName_N=[
	"shot","slash"
]

var SkillName_R=[
	"shot","slash"
]

var Hacsla_Lv =[
	"Lv1","Lv2","Lv3","Lv4"
]

var Skill_Rarelity = [
	SkillName_N,SkillName_N,SkillName_N,SkillName_R
]


func Get_Rand_Skill():
	var SR
	var Name
	randomize()
	Skill_Rarelity.shuffle()
	SR = Skill_Rarelity.pick_random()
	randomize()
	SR.shuffle()
	Name = SR.pick_random()
	return Name


func _UpSkillLv():
	RevisonLevel = {
	"Lv1":[1.0, 1.0, 1.0, 0, 0 , 1.0],
	"Lv2":[1.0, 1.0, 1.0, 0, 0 , 1.0],
	"Lv3":[1.0, 1.0, 1.0, 0, 0 , 1.0],
	"Lv4":[1.0, 1.0, 1.0, 0, 0 , 1.0],
	}




func _hacsla_LV():
	randomize()
	#ダメージ,詠唱時間,CT,金額倍率
	RevisonLevel = {
	"Lv1":[1.0, 1.0, 1.0, 1.0],
	"Lv2":[1.2, 1.0, 1.0, 1.2],
	"Lv3":[1.2, 0.83, 0.83, 1.5],
	"Lv4":[1.5, 0.83, 0.83, 2.0],
	"Lv5":[1.5, 0.67, 0.67, 2.5],
	"Lv6":[2.0, 0.67, 0.67, 4.0],
	}

func _LV_split(Number):
	match Number:
		-3:
			Number = 0.5
		-2:
			Number = 0.67
		-1:
			Number = 0.83
		0:
			Number = 1.0
		1:
			Number = 1.2
		2:
			Number = 1.5
		3:
			Number = 2.0
	return Number

func _hacsla(skillname:String,Level:String):
	var damageRevision#ダメージ補正
	var chargeRevision#詠唱時間補正
	var ctRevison#クールタイム補正
	#var _HPRevison#HPステータス
	#var _ATKRevison#攻撃力補正(全ての攻撃に影響する
	var revisondata
	var valuemult
	#var sumLV = 0
	skilldata = skilldict.get(skillname).duplicate()
	beforeSkillData = skilldict.get(skillname).duplicate()
	
	IsLight = false
	_hacsla_LV()
	
	revisondata = RevisonLevel.get(Level).duplicate()
	#damageRevision = snappedf(revisondata[0],0.01)
	damageRevision = revisondata[0]
	chargeRevision = revisondata[1]
	ctRevison = revisondata[2]
	#HPRevison = revisondata[3]
	#ATKRevison = revisondata[4]
	valuemult = revisondata[3]
	#sumLV += (damageRevision + chargeRevision + ctRevison)
	
	skilldata[1] *= _LV_split(damageRevision)
	skilldata[2] *= _LV_split(chargeRevision)
	skilldata[3] *= _LV_split(ctRevison)
	#skilldata[7] += HPRevison
	#skilldata[8] += ATKRevison
	skilldata[11] *= valuemult
	
	
	skilldata[1] = int(skilldata[1])
	skilldata[2] = snappedf(skilldata[2],0.01)
	skilldata[3] = snappedf(skilldata[3],0.01)
	skilldata[11] = int(skilldata[11])
	
	ColorSet.clear()
	
	for i in 3:
		if i == 0:
			if beforeSkillData[i+1] < skilldata[i+1]:
				ColorSet.append("plus")
			elif beforeSkillData[i+1] > skilldata[i+1]:
				ColorSet.append("minus")
			elif beforeSkillData[i+1] == skilldata[i+1]:
				ColorSet.append("equal")
		elif i >= 1:
			if beforeSkillData[i+1] > skilldata[i+1]:
				ColorSet.append("plus")
			elif beforeSkillData[i+1] < skilldata[i+1]:
				ColorSet.append("minus")
			elif beforeSkillData[i+1] == skilldata[i+1]:
				ColorSet.append("equal")
	
	return skilldata
	
	#match Level:
		#"Lv1":
		#	return skilldata
		#"Lv2":
		#	return skilldata
		#"Lv3":
		#	if sumLV > 3 || sumLV < -2:
		#		return skilldata
		#		pass
		#	else:
		#		return skilldata
		#"Lv4":
		#	if sumLV > 6 || sumLV < -5:
		#		return skilldata
		#		pass
		#	else:
		#		return skilldata
	
	#return skilldata

# Called when the node enters the scene tree for the first time.
func _ready():
	#威力、詠唱時間、CT、x距離(奇数)、y距離、スプライト,hp,atk,plain,load,value
	skilldict = {
		"shot":["shot",20,0.3,2,3,7,Pshot,0,0,"3x7の範囲に遠距離攻撃!","res://UI/HUD/sprite/kari_icon.png",10],
		"slash":["direct",20,0.1,2,3,2,Pslash,0,0,"3x2の範囲に素早い攻撃!","res://UI/HUD/sprite/kari_icon2.png",12],
		"explo":["direct",30,0.6,3,3,8,explo,0,0,"3x8の範囲の敵に爆発！","res://UI/HUD/sprite/kari_icon_3.png",12],
	}
	shot = skilldict.get("shot").duplicate()
	slash = skilldict.get("slash").duplicate()
	#explo
	uniquedict = {
		"dash":"a",
		"Barriar":"b"
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
