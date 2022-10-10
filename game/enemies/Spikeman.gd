extends KinematicBody2D

export var velocidad = 100.0

var gravedad = 800
var movimiento = Vector2.ZERO
var danio = 40

onready var animacion = $AnimatedSprite
onready var detector_vacio = $DetectorVacio
onready var detector_pared = $DetectorPared

func _physics_process(_delta):
	caer()
	caminar()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)
	
func caer():
	if not is_on_floor():
		movimiento.y = gravedad
		
func caminar():
	if not animacion.is_playing():
		animacion.play("caminar")
		
	if not detector_vacio.is_colliding() or detector_pared.is_colliding():
		velocidad *= -1
		detector_vacio.position *= -1
		detector_pared.position.x *= -1
		detector_pared.scale *= -1
		animar(animacion.flip_h)
		
	movimiento.x = velocidad
	
func animar(valor_actual):
	animacion.flip_h = !valor_actual
	
	
func _on_DetectorJugador_body_entered(body):
	body.danio_player(danio)
