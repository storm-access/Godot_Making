extends Node2D

@onready var HitRange = preload("res://About_Player/Player_Skill/player_skill_lange_block.tscn")#範囲
var RangeBlock
var Ranges:Array = []
var CheckIsRange = false#すでに存在するかどうか
@onready var timer = $Timer#rangeの消える時間

var slashInst
var slashs:Array = []
#@onready var Pshot = preload("res://player_slash.tscn")#中距離
#@onready var Pslash = preload("res://player_buturi.tscn")#近距離

var isExist = true#awaitチェック用の存在変数
var _PlayerBodyNodes
var _PlayerNodes
var _ChargeTimer
var _ChargeTime

var _thisSkillNumber

func _delete():
	if isExist == true:
		if Ranges.is_empty() == false:
			for i in Ranges:
				remove_child(i)
				i.queue_free()
			RangeBlock.queue_free()
			Ranges.clear()
		if slashs.is_empty() == false:
			for i in slashs:
				remove_child(i)
				i.queue_free()
			slashInst.queue_free()
			slashs.clear()
		isExist = false
		_PlayerNodes.isSkillNow = false
		_ChargeTimer.stop()
		_ChargeTime.visible = false
		queue_free()

#飛び道具タイプは敵に到着時にダメージ
#威力、詠唱時間、CT、x距離(奇数)、y距離、スプライト
func _shot(_damage,_chargeTime,_coolTime,_xRange,_yRange,_sprite):
	Global.EnemyHit = false#発動開始時は敵を検知しない
	var _PlayerNode = get_node("../Player_Body")
	var _PlayerAnim = get_node("../Player_Body/AnimatedSprite2D")
	var _Enemy = get_node("../../Enemy")
	#_PlayerAnim.play("Idle_right")
	timer.wait_time = _chargeTime#詠唱時間の設定
	CheckIsRange = true
	var _startposition = _PlayerNode.global_position
	
	_directionChange(_PlayerNodes.NowDirection,_xRange,_yRange)
	
	_ChargeTimer.wait_time = timer.wait_time#詠唱時間の同期
	timer.start()#詠唱開始
	_ChargeTimer.start()
	_ChargeTime.visible = true
	
	await timer.timeout#詠唱終了時
	if isExist == true:#このノードが存在していれば
		if Global.EnemyHit == false:#範囲内に敵がいなければ
			_delete()
		if Global.EnemyHit == true:#範囲内に敵がいれば
			_PlayerNode.CanMoving = false#プレイヤーは発動中動けない
			_skillNumCheck(_coolTime)
			for i in Ranges:#発動中は範囲を非表示に
				i.visible = false
			slashInst = _sprite.instantiate()#攻撃の生成
			slashs.append(slashInst)
			add_child(slashInst)
			slashInst.global_position = _startposition
			_SetRotationToDirection(slashInst,_PlayerNodes.NowDirection)
			var movet = 0.0
			
			for i in 10:#0.1秒をかけて敵に飛んでいく
				movet += 0.1
				if isExist == true:#このノードが存在していれば
					await get_tree().create_timer(0.01).timeout
					slashInst.global_position = _startposition.lerp(_Enemy.global_position,movet)
			
			if isExist == true:#このノードが存在していれば
				print(str(_damage * PowerUp.MultAtk()))
				EnemyStatus._hurt(_damage * PowerUp.MultAtk())
				pass#ダメージの処理を描く
			
			if isExist == true:#このノードが存在していれば
				_PlayerNode.CanMoving = true#プレイヤーが動けるように
				_delete()

#直接タイプはモーション完了後にダメージ
#威力、詠唱時間、CT、x距離(奇数)、y距離、スプライト
func _direct(_damage,_chargeTime,_coolTime,_xRange,_yRange,_sprite):
	Global.EnemyHit = false#発動開始時は敵を検知しない
	var _PlayerNode = get_node("../Player_Body")
	var _PlayerAnim = get_node("../Player_Body/AnimatedSprite2D")
	var _Enemy = get_node("../../Enemy")
	#_PlayerAnim.play("Idle_right")
	timer.wait_time = _chargeTime#詠唱時間の設定
	CheckIsRange = true
	var _startposition = _PlayerNode.global_position
	var _shiftx = int(_xRange/2)+1
	
	_directionChange(_PlayerNodes.NowDirection,_xRange,_yRange)
	
	_ChargeTimer.wait_time = timer.wait_time#詠唱時間の同期
	timer.start()#詠唱開始
	_ChargeTimer.start()
	_ChargeTime.visible = true
	
	await timer.timeout#詠唱終了時
	if isExist == true:#このノードが存在していれば
		if Global.EnemyHit == false:#範囲内に敵がいなければ
			_delete()
		if Global.EnemyHit == true:#範囲内に敵がいれば
			_PlayerNode.CanMoving = false#プレイヤーは発動中動けない
			_skillNumCheck(_coolTime)
			for i in Ranges:#発動中は範囲を非表示に
					i.visible = false
			slashInst = _sprite.instantiate()#攻撃の生成
			slashs.append(slashInst)
			add_child(slashInst)
			slashInst.global_position = _Enemy.global_position
			slashInst.get_child(0).visible = true
			slashInst.get_child(0).play("default")
			
			if isExist == true:#このノードが存在していれば
				#await get_tree().create_timer(0.3).timeout
				await slashInst.motionEnd#モーション終了を待つ
				
				if isExist == true:#このノードが存在していれば
					print(str(_damage * PowerUp.MultAtk()))
					EnemyStatus._hurt(_damage * PowerUp.MultAtk())
					pass#ダメージの処理を描く
				
				if isExist == true:#このノードが存在していれば
					_PlayerNode.CanMoving = true#プレイヤーが動けるように
					_delete()


func _skillNumCheck(_coolTime):
	if _thisSkillNumber == 1:
		PlayerInBattleStatus.CT_Skill1.wait_time = _coolTime
		PlayerInBattleStatus.CT_Skill1.start()
		PlayerInBattleStatus.can_use_skill1 = false
	elif _thisSkillNumber == 2:
		PlayerInBattleStatus.CT_Skill2.wait_time = _coolTime
		PlayerInBattleStatus.CT_Skill2.start()
		PlayerInBattleStatus.can_use_skill2 = false
	elif _thisSkillNumber == 3:
		PlayerInBattleStatus.CT_Skill3.wait_time = _coolTime
		PlayerInBattleStatus.CT_Skill3.start()
		PlayerInBattleStatus.can_use_skill3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_PlayerNodes = get_node("../")
	_PlayerBodyNodes = get_node("../Player_Body")
	_ChargeTimer = get_node("../Player_Body/ChargeTimer")
	_ChargeTime = get_node("../Player_Body/ChargeTime")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isExist == true:
		if _PlayerBodyNodes.IsMoving == true:#に動いてたら
			_delete()


func _directionChange(_direction,_xRange,_yRange):
	var _startposition = _PlayerBodyNodes.global_position
	var _shiftx = int(_xRange/2)+1
	match _direction:
		"right":#右上
			for x in _xRange:
				for y in _yRange:
					RangeBlock = HitRange.instantiate()
					Ranges.append(RangeBlock)
					add_child(RangeBlock)
					RangeBlock.global_position = _startposition
					RangeBlock.global_position -= Global.get_positions(x,y)
					RangeBlock.global_position += Global.get_positions(_shiftx,0)
		"left":#左下
			for x in _xRange:
				for y in _yRange:
					RangeBlock = HitRange.instantiate()
					Ranges.append(RangeBlock)
					add_child(RangeBlock)
					RangeBlock.global_position = _startposition
					RangeBlock.global_position += Global.get_positions(x,y)
					RangeBlock.global_position += Global.get_positions(0,_shiftx)
		"front":#左上
			for x in _xRange:
				for y in _yRange:
					RangeBlock = HitRange.instantiate()
					Ranges.append(RangeBlock)
					add_child(RangeBlock)
					RangeBlock.global_position = _startposition
					RangeBlock.global_position -= Global.get_positions(y,x)
					RangeBlock.global_position += Global.get_positions(0,_shiftx)
		"back":#右下
			for x in _xRange:
				for y in _yRange:
					RangeBlock = HitRange.instantiate()
					Ranges.append(RangeBlock)
					add_child(RangeBlock)
					RangeBlock.global_position = _startposition
					RangeBlock.global_position += Global.get_positions(y,x)
					RangeBlock.global_position += Global.get_positions(_shiftx,0)

func _SetRotationToDirection(_item,_direction):
	match _direction:
		"right":#右上
			pass
		"left":#左下
			_item.get_child(0).flip_h = true
			_item.get_child(0).flip_v = true
		"front":#左上
			_item.get_child(0).flip_h = true
		"back":#右下
			_item.get_child(0).flip_v = true
