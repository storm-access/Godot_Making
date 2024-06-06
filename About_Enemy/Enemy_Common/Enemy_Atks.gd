extends Node

@onready var atk = preload("res://About_Enemy/Enemy_Status/enemy_skill_hit_block.tscn")

var atks
var ef
var tilessum = []
var xs
var ys
#var s = xline.new().atk
var isExist = true#awaitチェック用の存在変数
#var isExist_tile = true
#var isExist_effect = true

func _delete():
	if isExist == true:
		for i in tilessum:
			remove_child(i)
			i.queue_free()
			atks.queue_free()
		tilessum.clear()
		remove_child(ef)
		ef.queue_free()
		isExist = false
		queue_free()

func _Xline(_atk,_xRange,_xCenter,_sprite):#Xの列に攻撃,(ダメージ、x範囲、xの中心)
	randomize()
	xs = _xCenter
	for i in Global.len_y:
		atks = atk.instantiate()
		atks.global_position = Global.get_positions(xs,i)
		tilessum.append(atks)
		add_child(atks)
		if _xRange >= 2:
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs+1,i)
			tilessum.append(atks)
			add_child(atks)
		if _xRange >= 3:
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs-1,i)
			tilessum.append(atks)
			add_child(atks)
		if _xRange >= 4:
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs+2,i)
			tilessum.append(atks)
			add_child(atks)
		if _xRange >= 5:
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs-2,i)
			tilessum.append(atks)
			add_child(atks)
			
	if isExist == true:
		await get_tree().create_timer(2).timeout
		ef = _sprite.instantiate()
		ef.global_position = Global.get_positions(xs,0)
		ef.damage = _atk
		add_child(ef)
		var t = 0
		if isExist == true:
			for i in 10:
				await get_tree().create_timer(0.02).timeout
				t += 0.1
				ef.global_position = Global.get_positions(xs,0).lerp(Global.get_positions(xs,16),t)
			if isExist == true:
				await get_tree().create_timer(0.1).timeout
				_delete()

func _Yline(_atk,_yRange,_yCenter,_sprite):#Yの列に攻撃,(ダメージ、y範囲、yの中心)
	randomize()
	ys = _yCenter
	for i in Global.len_x:
		atks = atk.instantiate()
		atks.name = "tile"+str(i)
		atks.global_position = Global.get_positions(i,ys)
		tilessum.append(atks)
		add_child(atks)
		if _yRange >= 2:
			atks = atk.instantiate()
			atks.name = "tile"+str(i)
			atks.global_position = Global.get_positions(i,ys-1)
			tilessum.append(atks)
			add_child(atks)
		if _yRange >= 3:
			atks = atk.instantiate()
			atks.name = "tile"+str(i)
			atks.global_position = Global.get_positions(i,ys+1)
			tilessum.append(atks)
			add_child(atks)
		if _yRange >= 4:
			atks = atk.instantiate()
			atks.name = "tile"+str(i)
			atks.global_position = Global.get_positions(i,ys-2)
			tilessum.append(atks)
			add_child(atks)
		if _yRange >= 5:
			atks = atk.instantiate()
			atks.name = "tile"+str(i)
			atks.global_position = Global.get_positions(i,ys+2)
			tilessum.append(atks)
			add_child(atks)
			
	if isExist == true:
		await get_tree().create_timer(2).timeout
		ef = _sprite.instantiate()
		ef.global_position = Global.get_positions(0,ys)
		ef.damage = _atk
		ef.global_rotation_degrees = -125
		add_child(ef)
		
		var t = 0
		if isExist == true:
			for i in 10:
				await get_tree().create_timer(0.02).timeout
				t += 0.1
				ef.global_position = Global.get_positions(0,ys).lerp(Global.get_positions(22,ys),t)
		
			if isExist == true:
				await get_tree().create_timer(0.1).timeout
				_delete()

func _Circles(_atk,n:int,_xCenter,_yCenter,_sprite):#円範囲に攻撃
	randomize()
	xs = _xCenter
	randomize()
	ys = _yCenter
	for x in n:
		for y in n:
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs+x,ys+y)
			atks.damage = _atk
			tilessum.append(atks)
			add_child(atks)
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs-x,ys+y)
			atks.damage = _atk
			tilessum.append(atks)
			add_child(atks)
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs-x,ys-y)
			atks.damage = _atk
			tilessum.append(atks)
			add_child(atks)
			atks = atk.instantiate()
			atks.global_position = Global.get_positions(xs+x,ys-y)
			atks.damage = _atk
			tilessum.append(atks)
			add_child(atks)
			
	if isExist == true:
		await get_tree().create_timer(2).timeout
		ef = _sprite.instantiate()
		ef.global_position = Global.get_positions(xs,0)
		add_child(ef)
		ef.global_position = Global.get_positions(xs,ys)
		ef.global_position -= Global.get_positions(1,1)
		for i in tilessum:
			i.areaDamage = true
	
		if isExist == true:
			await get_tree().create_timer(0.5).timeout
			_delete()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
