extends Node

var HP
var MaxHP
var Name
var Money

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _hurt(damage):
	HP -= damage
	#print(get_node("/"))
