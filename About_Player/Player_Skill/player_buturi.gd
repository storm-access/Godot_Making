extends Node2D

signal motionEnd

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animated_sprite_2d_animation_finished():
	motionEnd.emit()
