extends Area2D

var esta_activada = false
export var proximo_nivel = ""

func _on_body_entered(body):
	if esta_activada:
		
		body.play_entrar_portal(global_position)
		yield(get_tree().create_timer(2.0), "timeout")
		cambiar_nivel()
		
func cambiar_nivel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(proximo_nivel)

func play_animacion():
	esta_activada = true
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("activado")
