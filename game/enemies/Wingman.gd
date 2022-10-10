extends Area2D

onready var detector_jugador = $DetectorJugador
onready var detector_pisoton = $DetectorPisoton/ColisionadorCabeza
onready var animacion = $AnimationPlayer

var danio = 35

func _on_DetectorPisoton_body_entered(body):
	desactivar_colisionador([detector_jugador, detector_pisoton])
	animacion.stop()
	animacion.play("morir") 
	body.impulsar()

	
func desactivar_colisionador(colisionadores):
	for colisionador in colisionadores:
		colisionador.set_deferred("disabled", true)
		colisionador.set_deferred("visible", false)
		

func _on_Wingman_body_entered(body):
	body.danio_player(danio)
	
