extends Control

@onready var Transition = preload("res://transition.tscn")
var TransitionInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():#soloplayボタンを押したらアニメーション開始
	$Button/AnimationPlayer.play("new_animation")
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):#animation終了後
	if anim_name == "new_animation":
		TransitionInstance = Transition.instantiate()
		add_child(TransitionInstance)
		TransitionInstance.transitionEnd.connect(_InToGame)
		TransitionInstance.IsFadeIn = true#トランジション開始のスイッチ


func _InToGame():
	remove_child(TransitionInstance)
	TransitionInstance.queue_free()
	Global.LevelChange(Global.GuildLevel)
