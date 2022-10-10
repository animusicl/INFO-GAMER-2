extends Node2D

onready var detector_jugador = $Sprite/RayCast2D
onready var posicion_disparo = $Sprite/posicionDisparo
onready var timer = $Timer
onready var sfx_rayos = $Rayos

export var rayo: PackedScene

var puede_disparar = true
var danio = 50

func _process(_delta):
	if detector_jugador.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = false
		timer.start()
		
		
func disparar():
	sfx_rayos.play()
	var nuevo_rayo = rayo.instance()
	nuevo_rayo.crear(posicion_disparo.global_position)
	add_child(nuevo_rayo)
	

func _on_Timer_timeout():
	puede_disparar = true
