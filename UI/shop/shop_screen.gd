extends Control

@onready var InShopSkill = preload("res://UI/shop/skill_shop.tscn")
var SkillInst
var shop_List = []
var Positions = [
	Vector2(100,100),
	Vector2(500,100),
	Vector2(100,300),
	Vector2(500,300),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func GetSkill():
	for i in 4:
		SkillInst = InShopSkill.instantiate()
		shop_List.append(SkillInst)
		shop_List[i].SetText(SkillList._hacsla(SkillList.Get_Rand_Skill(),"Lv4"))
		add_child(SkillInst)
		SkillInst.global_position = Positions[i]


func _delete():
	get_parent().remove_child(self)
	queue_free()

func _on_button_button_up():
	get_node("../").remove_child(self)
	PlayerStatus.InShopNow = false
	pass # Replace with function body.
