extends AnimatedSprite2D

var _timer:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_timer -= delta
	if _timer <= 0:
		queue_free()

	var alpha = _timer * 0.5
	modulate.a = alpha

func start(_position:Vector2, _frame):
	get_parent().global_position = _position
	self.play(_frame)
	_timer = 0.5
	modulate = Color8(128,128,255,128)
