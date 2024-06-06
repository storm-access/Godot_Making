extends CharacterBody2D


const SPEED = 100.0


var target_position: Vector2
var moving = false
var x
var setposi: Vector2
var HighOrLow = true#位置調整用のふらぐ


func _ready():
	# 最初の目標位置をランダムに設定
	randomize()
	x = randi_range(2,15)
	setposi = Global.get_positions(x,3)
	# _move_to_random_position関数を呼び出すタイマーを設定
	$Timer_Moving.wait_time = 2
	$Timer_Moving.start()

func _physics_process(_delta):
	var direction = (setposi - global_position).normalized()
	velocity = direction * SPEED
	if moving:
		move_and_slide()


func _move_to_random_position():#ランダムな位置に移動
	# 移動中の場合は何もしない
	if moving:
		return
	# 新しいランダムな位置を設定
	randomize()
	x = randi_range(2,15)
	setposi = Global.get_positions(x,3)
	# 移動フラグを立てる
	moving = true
	# 3秒後に停止するためのタイマーをスタート
	$Timer_MoveEnd.wait_time = 3
	$Timer_MoveEnd.start()


func _on_timer_timeout():#Timer_Moving
	_move_to_random_position()


func _on_timer_move_end_timeout():
	if moving:
		# 移動を停止
		moving = false
	# 3秒後に再度移動するためのタイマーをスタート
	$Timer_Moving.wait_time = 3
	$Timer_Moving.start()
