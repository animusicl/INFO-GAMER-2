extends StaticBody2D


func _on_DetectorPersonaje_body_entered(_body):
	$AnimationPlayer.play("caer")

func deshabilitar_colisionador():
	$DetectorPersonaje/CollisionShape2D.set_deferred("disabled", true)
	$Colisionador.set_deferred("disabled", true)
