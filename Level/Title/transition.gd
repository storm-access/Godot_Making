extends Control

@onready var shaders := $Panel.material as ShaderMaterial
#@onready var shaders2 := shaders.shader

var soft_range = 0.02#透明度的な
var fade_value :float = 1.0#フェード値0~1
var mask_img:Texture#マスク画像は今はUIで設定してるからいらないかも

var IsFadeIn = false#トランジション開始のスイッチ
var IsFadeOut = false

signal transitionEnd#トランジションの終了通知


func _ready():
	shaders.set_shader_parameter("SoftRange",soft_range)
	shaders.set_shader_parameter("Value",fade_value)

func _process(_delta: float):
	if IsFadeIn:
		_fadein(_delta)
	if IsFadeOut:
		_fadeout(_delta)
	shaders.set_shader_parameter("Value", fade_value)

func _fadein(delta):
	var t = 0.0
	t += delta*0.8
	fade_value -= t
	if fade_value <= 0.0:
		transitionEnd.emit()

func _fadeout(delta):
	var t = 0.0
	t += delta*0.8
	fade_value += t
	if fade_value >= 1.0:
		transitionEnd.emit()
