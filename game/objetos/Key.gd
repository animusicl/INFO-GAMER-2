extends Area2D
signal consumida() 

func _on_body_entered(_body):
	PlayerInfo.restar_llaves()
	emit_signal("consumida")
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("consumir")
