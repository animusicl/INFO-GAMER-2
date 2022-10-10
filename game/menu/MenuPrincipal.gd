extends Control

export var nivel = ""

func _ready():
	PlayerInfo.reset()

func _on_BotonIniciar_pressed():
	get_tree().paused = false
	GlobalMusic.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel)
