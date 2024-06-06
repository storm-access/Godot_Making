extends Node2D

@onready var camera = $Camera2D
#var PlayerHP = 100
var IsHit = false
@onready var sprite = $Player_Body/AnimatedSprite2D
var spriteinst
var t = 0.0
var leper
var flag = 0

var candash = true#ダッシュのクールダウン
var switch = false
var isdashed = false
var spritescontainer:Array

@onready var PAttack = preload("res://About_Player/Player_Skill/player_atks.tscn")
var PA
var PAs = []
var PAnumber = 0#インスタンス識別用

var isSkillNow = false

var Skill

@onready var ChargeTimer = $Player_Body/ChargeTimer
@onready var ChargeTimeDisplay = $Player_Body/ChargeTime

var NowDirection:String = "right"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Body.dash.connect(_dashed)
	PlayerInBattleStatus.CT_Unique.timeout.connect(func():candash = true) 
	#Skill = SkillList.skilldict.get("shot")
	#print(Skill)
	camera.limit_left = Global.CameraLimit[0]
	camera.limit_top = Global.CameraLimit[1]
	camera.limit_right = Global.CameraLimit[2]
	camera.limit_bottom = Global.CameraLimit[3]
	#PlayerStatus.skill1 = SkillList.shot#仮で技を配置
	#PlayerStatus.skill2 = SkillList.slash#仮で技を配置
	#if Global.NowLevel == Global.BattleLevel:
		#PlayerStatus.skill1 = SkillList._hacsla("shot","Lv1")
		#PlayerStatus.skill2 = SkillList._hacsla("slash","Lv1")
		#print(PlayerStatus.skill1)
		#print(PlayerStatus.skill2)
		#PlayerStatus._statusSet()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.global_position = $Player_Body.global_position
	t += 8*_delta
	if IsHit == true:
		if flag == 0:
			leper = Vector2(255,0).lerp(Vector2(128,0),t)
			$Player_Body/AnimatedSprite2D.modulate = Color8(255,int(leper.x),int(leper.x),255)
			if leper.x <= 128.00:
				flag = 1
				t = 0
		elif flag == 1:
			leper = Vector2(128,0).lerp(Vector2(255,0),t)
			$Player_Body/AnimatedSprite2D.modulate = Color8(255,int(leper.x),int(leper.x),255)
			if leper.x >= 255:
				flag = 0
				t = 0
	elif IsHit == false:
		if isdashed == false:
			$Player_Body/AnimatedSprite2D.modulate = Color8(255,255,255,255)
	
	if isSkillNow == false:
		if Input.is_action_just_pressed("shot_skill1"):
			if Input.is_action_just_pressed("shot_skill2")==false:#同時押し対策
				if PlayerInBattleStatus.can_use_skill1 == true:#クールタイムの確認
					_skillset(PlayerStatus.skill1)
					PA._thisSkillNumber = 1
		
		if Input.is_action_just_pressed("shot_skill2"):
			if Input.is_action_just_pressed("shot_skill1")==false:#同時押し対策
				if PlayerInBattleStatus.can_use_skill2 == true:#クールタイムの確認
					_skillset(PlayerStatus.skill2)
					PA._thisSkillNumber = 2
		
		if Input.is_action_just_pressed("shot_skill3"):
			if Input.is_action_just_pressed("shot_skill1")==false:#同時押し対策
				if PlayerInBattleStatus.can_use_skill3 == true:#クールタイムの確認
					_skillset(PlayerStatus.skill3)
					PA._thisSkillNumber = 3
	
	ChargeTimeDisplay.text = str("%.2f" %ChargeTimer.time_left)


func _hurt(damage):
	if IsHit == false && isdashed == false:
		PlayerStatus.PlayerHP -= damage
		print(PlayerStatus.PlayerHP)
		IsHit = true
	await get_tree().create_timer(0.7).timeout#damageを受けてから0.7秒は無敵
	IsHit = false

func _dashed():
	isdashed = true
	#var didposi:Vector2 = self.global_position
	for i in 5:
		$Player_Body/AnimatedSprite2D.modulate = Color8(128,128,255,64+(i*30))
		await get_tree().create_timer(0.001).timeout
		spriteinst = sprite.duplicate()
		add_child(spriteinst)
		spritescontainer.append(spriteinst)
		spriteinst.global_position = $Player_Body.zanzouposi.lerp($Player_Body.global_position,1.0*i/5)
		spriteinst.play($Player_Body/AnimatedSprite2D.animation)
		spriteinst.modulate = Color8(128,128,255,64+(i*20))
	
	await get_tree().create_timer(0.25).timeout
	for i in spritescontainer:
		remove_child(i)
		i.queue_free()
	spriteinst.queue_free()
	spritescontainer.clear()
	isdashed = false

func _skillset(_skillinfo):#スキル情報によってスキルの形を切り替える
	if _skillinfo[0] == "shot":
		isSkillNow = true
		PA = PAttack.instantiate()
		PAs.append(PA)
		add_child(PA)
		PA._shot(_skillinfo[1],_skillinfo[2],_skillinfo[3],_skillinfo[4],_skillinfo[5],_skillinfo[6])

	elif _skillinfo[0] == "direct":
		isSkillNow = true
		PA = PAttack.instantiate()
		PAs.append(PA)
		add_child(PA)
		PA._direct(_skillinfo[1],_skillinfo[2],_skillinfo[3],_skillinfo[4],_skillinfo[5],_skillinfo[6])


func _on_charge_timer_timeout():
	ChargeTimeDisplay.text = str(0.0)
	ChargeTimeDisplay.visible = false
