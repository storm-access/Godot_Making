extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _SetText(SkillData):
	$VBoxContainer/Damage.text = "Damage : " + str(SkillData[1])
	$VBoxContainer/Activation.text = "Activation : " + str(SkillData[2]) +"s"
	$VBoxContainer/CT.text = "CoolTime : " + str(SkillData[3]) +"s"
	#$VBoxContainer/HP.text = "HP : +" + str(SkillData[7])
	#$VBoxContainer/ATK.text = "ATK : +" + str(SkillData[8])
	$Explain.text = str(SkillData[9])
	$TextureRect.texture = load(SkillData[10])

func _delete():
	queue_free()
