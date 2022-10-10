extends Control

onready var etiqueta_vidas = $LlivesContainer/Cantidad
onready var etiqueta_moneda_oro = $GoldContainer/Cantidad
onready var etiqueta_moneda_plata = $SilverContainer/Cantidad
onready var etiqueta_moneda_bronce = $BronzeContainer/Cantidad
onready var etiqueta_llaves = $KeyContainer/Cantidad

func _ready():
# warning-ignore:return_value_discarded
	PlayerInfo.connect("actualizar_datos", self, "actualizar_hud")
	actualizar_hud()
	
func actualizar_hud():
	etiqueta_vidas.text = "%s"%PlayerInfo.vidas
	etiqueta_moneda_oro.text = "%s"%PlayerInfo.monedas_oro
	etiqueta_moneda_plata.text = "%s"%PlayerInfo.monedas_plata
	etiqueta_moneda_bronce.text = "%s"%PlayerInfo.monedas_bronce
	etiqueta_llaves.text = "%s"%PlayerInfo.llaves
	

