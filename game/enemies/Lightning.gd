extends Area2D

export var velocidad = 400.0

onready var animacion = $AnimatedSprite

var mi_pos = Vector2.ZERO
var danio = 15

func crear(posicion):
	mi_pos = posicion 

func _ready():
	global_position = mi_pos
	animacion.play("caer")
	
func _process(delta):
	global_position.y += velocidad * delta

func _on_VisibilityNotifier2D_screen_exited():
	destruirse()

func destruirse():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.danio_player(danio)
		
	destruirse()
