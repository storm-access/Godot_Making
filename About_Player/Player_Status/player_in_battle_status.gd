extends Node2D

@onready var CT_Skill1 = $CT1
@onready var CT_Skill2 = $CT2
@onready var CT_Skill3 = $CT3
@onready var CT_Unique = $CT_U

var can_use_skill1 = true#クールタイム用
var can_use_skill2 = true
var can_use_skill3 = true
var can_use_Unique = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#if can_use_skill1 == false:
		#print(CT_Skill1.time_left)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_ct_1_timeout():
	can_use_skill1 = true


func _on_ct_2_timeout():
	can_use_skill2 = true


func _on_ct_3_timeout():
	can_use_skill3 = true


func _on_ct_u_timeout():
	can_use_Unique = true
