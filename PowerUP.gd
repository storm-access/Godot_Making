extends Node

var List = {
	"Revange":["HPが20%以下の時、ダメージが2倍",false],#addAtk
	"FullHealth":["HPが満タンのとき、ダメージが2倍",false],#addAtk
	"LimitLife":["一撃でやられる代わりに3残機制になる",false],
	"AddGuard":["スタミナゲージを追加。ゲージを消費するが、ガード機能を追加する",false],
	"IronWill":["一度だけHP1で耐える",false],
	"ChangeShooting":["スキルの代わりに弾を発射するようになる",false],
	"AddMovement":["敵が動くようになるが、受けるダメージが少し減る",false],
	"PerfectTime":["敵の攻撃が弾幕になる",false],
}

var addAtk_R = 1.0
var addAtk_F = 1.0
var addATK = 1.0

func MultAtk():
	addAtk_R = 1.0
	addAtk_F = 1.0
	addATK = 1.0
	Revange()
	FullHealth()
	addATK *= addAtk_F*addAtk_R
	return addATK


func Revange():
	if PlayerStatus.PlayerHP < 21:
		if List.get("Revange")[1] == true:
			addAtk_R = 2.0
		else:
			addAtk_R = 1.0
		
func FullHealth():
	if PlayerStatus.PlayerHP == 100:
		if List.get("FullHealth")[1] == true:
			addAtk_F = 2.0
		else:
			addAtk_F = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
