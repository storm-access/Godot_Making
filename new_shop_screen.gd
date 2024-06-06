extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():
	get_node("../").remove_child(self)
	PlayerStatus.InShopNow = false
	pass # Replace with function body.


func _on_button_2_button_up():
	PowerUp.List.get("Revange")[1] = true
	pass # Replace with function body.


func _on_button_3_button_up():
	PowerUp.List.get("FullHealth")[1] = true
