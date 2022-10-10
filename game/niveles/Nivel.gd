extends Node

export var menuGameOver = "res://game/menu/MenuGameOver.tscn"
export var nivel_actual = "" 

var numero_llaves = 0
var contenedor_llaves

onready var nubes_lejanas = $ParallaxBackground/ParallaxHighClouds

func _ready():
# warning-ignore:return_value_discarded
	PlayerInfo.connect("game_over", self,"game_over")
	contenedor_llaves = get_node_or_null("Keys")
	if contenedor_llaves != null: 
		numero_llaves_nivel()
		
# warning-ignore:unused_argument
func _process(delta):
	nubes_lejanas.motion_offset.x -= 5
	
func numero_llaves_nivel():
	numero_llaves = contenedor_llaves.get_child_count()
	PlayerInfo.contabilizar_llaves(numero_llaves)
	for llave in contenedor_llaves.get_children():
		llave.connect("consumida", self, "llaves_restantes")
	
func llaves_restantes():
	numero_llaves -= 1
	if numero_llaves == 0:
		var portal = get_node_or_null("Portal")
		portal.play_animacion()
		
func game_over():
	PlayerInfo.nivel_actual = nivel_actual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menuGameOver)
		

