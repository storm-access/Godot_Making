extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("ExplainMovie")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():
	PlayerStatus.InShopNow = false
	get_parent().remove_child(self)
	queue_free()
	
