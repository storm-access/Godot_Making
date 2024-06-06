extends CharacterBody2D

class_name Player_No

var speed = 500
@export var acceleration = 256
@export var max_speed = 64
@export var max_dash_speed = 80 
@export var friction = 0.1
@export var gravity = 512
@export var jump_force = 224*2
@export var air_resistance = 0.02
var gravity2 = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D

var issametime = false

@onready var Collision1 = $foot_1#foot_1
@onready var Collision2 = $foot_2#foot_2

var zanzouposi:Vector2
var zanzoudirection

signal dash
var IsMoving = false
#var CanMoving = true

@onready var PlayerNode = get_node("../")

var collision_lib = {
	"back":[Vector2(0,55),0],
	"front":[Vector2(-1,50),180],
	"left":[Vector2(-2,54),0],
	"right":[Vector2(2,51),180]
}

func _physics_process(_delta):
	if PlayerStatus.InShopNow == false:
		PlayerStatus.CanMoving = true
	elif PlayerStatus.InShopNow == true:
		PlayerStatus.CanMoving = false
		sprite.play("Idle_front")
		
	velocity = Vector2.ZERO
	if PlayerStatus.CanMoving == true:
		get_key()
	velocity = velocity.normalized() * speed
	speed = 500
	#if not is_on_floor():
	#velocity.y += gravity2 * delta
	move_and_slide()


func get_key():
	if Input.is_action_pressed("direction_change") == false:#ctrlを押しながらだと方向転換
		if Input.is_action_pressed("move_right"):#wasd操作
			IsMoving = true
			#wasd操作の同時押しあれこれ
			if (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_down")||Input.is_action_pressed("move_up")) == false:
				velocity.x += 2
				velocity.y += 1
				sprite.play("walk_back")
				set_collision("back")
			elif (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_down")||Input.is_action_pressed("move_up")) == true:
				sprite.play("Idle_right")
				set_collision("right")
				
		if Input.is_action_pressed("move_left"):
			IsMoving = true
			if (Input.is_action_pressed("move_right")||Input.is_action_pressed("move_down")||Input.is_action_pressed("move_up")) == false:
				velocity.x -= 2
				velocity.y -= 1
				sprite.play("walk_front")
				set_collision("front")
			elif (Input.is_action_pressed("move_right")||Input.is_action_pressed("move_down")||Input.is_action_pressed("move_up")) == true:
				sprite.play("Idle_right")
				set_collision("right")
				
		if Input.is_action_pressed("move_down"):
			IsMoving = true
			if (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_right")||Input.is_action_pressed("move_up")) == false:
				velocity.x -= 2
				velocity.y += 1
				sprite.play("walk_left")
				set_collision("left")
			elif (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_right")||Input.is_action_pressed("move_up")) == true:
				sprite.play("Idle_right")
				set_collision("right")
		
		if Input.is_action_pressed("move_up"):
			IsMoving = true
			if (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_right")||Input.is_action_pressed("move_down")) == false:
				velocity.x += 2
				velocity.y -= 1
				sprite.play("walk_right")
				set_collision("right")
			elif (Input.is_action_pressed("move_left")||Input.is_action_pressed("move_right")||Input.is_action_pressed("move_down")) == true:
				sprite.play("Idle_right")
				set_collision("right")
	#移動方向に応じて離したときに待機へ
	if Input.is_action_just_released("move_right"):
		IsMoving = false
		sprite.play("Idle_back")
		set_collision("back")
	if Input.is_action_just_released("move_left"):
		IsMoving = false
		sprite.play("Idle_front")
		set_collision("front")
	if Input.is_action_just_released("move_up"):
		IsMoving = false
		sprite.play("Idle_right")
		set_collision("right")
	if Input.is_action_just_released("move_down"):
		IsMoving = false
		sprite.play("Idle_left")
		set_collision("left")


func set_collision(move:String):
	if move == "front":
		Collision1.disabled = false
		Collision1.visible = true
		Collision2.disabled = true
		Collision2.visible = false
		Collision1.position = collision_lib.get("front")[0]
		Collision1.rotation_degrees = collision_lib.get("front")[1]
		PlayerNode.NowDirection = "front"
	if move == "back":
		Collision1.disabled = false
		Collision1.visible = true
		Collision2.disabled = true
		Collision2.visible = false
		Collision1.position = collision_lib.get("back")[0]
		Collision1.rotation_degrees = collision_lib.get("back")[1]
		PlayerNode.NowDirection = "back"
	if move == "left":
		Collision1.disabled = true
		Collision1.visible = false
		Collision2.disabled = false
		Collision2.visible = true
		Collision2.position = collision_lib.get("left")[0]
		Collision2.rotation_degrees = collision_lib.get("left")[1]
		PlayerNode.NowDirection = "left"
	if move == "right":
		Collision1.disabled = true
		Collision1.visible = false
		Collision2.disabled = false
		Collision2.visible = true
		Collision2.position = collision_lib.get("right")[0]
		Collision2.rotation_degrees = collision_lib.get("right")[1]
		PlayerNode.NowDirection = "right"
