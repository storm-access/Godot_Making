extends Control

@onready var HPbar = $TextureProgressBar
var hpvalue

#@onready var onFieldEnemy = get_node("../../Enemy")
var onFieldEnemy

# Called when the node enters the scene tree for the first time.
func _ready():
	#HPbar.max_value = EnemyStatus.HP
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hpvalue = EnemyStatus.HP
	HPbar.value = hpvalue
	onFieldEnemy._hurt()
