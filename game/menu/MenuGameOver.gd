extends Control

var nivel_actual = PlayerInfo.nivel_actual

func _ready():
	nivel_actual = PlayerInfo.nivel_actual
	PlayerInfo.reset()

func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene( "res://game/menu/MenuPrincipal.tscn")


func _on_BotonContinuar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)
