extends StaticBody2D

export var es_movediza = false
var color_movediza = Color.peru

func activar_plataforma():
	$AnimationPlayer.play("moverse")
	
func _process(_delta):
	if es_movediza:
		$Sprite.modulate = color_movediza
		activar_plataforma()

