extends Control

func _ready():
	$Score/layer.text = "Score {p}".format({"p":PlayerInfo.generar_puntaje()})


func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene( "res://game/menu/MenuPrincipal.tscn")
