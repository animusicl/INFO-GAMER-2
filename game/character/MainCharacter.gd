extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var acel_caida = 400
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800
export var acel_caida_power_up = 60
var salud = 100

var movimiento = Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse = true

onready var animacion = $animation
onready var audio_salto = $AudioSalto
onready var camara = $Camera2D
onready var timer_salto = $EnfriamientoPowerUpJump 
onready var timer_volar = $EnfriamientoPoweUpFly
onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("aclarar")
	fuerza_salto_original = fuerza_salto
	acel_caida_original = acel_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	caer()
	saltar()		
	colision_techo()
	caida_al_vacio()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)
	 
func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierdo")
		if direccion == 0:
			animacion.play("idle")
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false 
			animacion.play("correr")
	
	return direccion
	
func caer():
	if not is_on_floor():
		animacion.play("saltar")
		movimiento.y += acel_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)
	
func saltar():
	if Input.is_action_just_pressed("salto") and is_on_floor() and puede_moverse:
		audio_salto.play()
		animacion.play("saltar")
		saltar_movimiento()
		
		
func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto
		
func impulsar():
	movimiento.y = impulso
	
func cambiar_fuerza_salto():
	timer_salto.start()
	fuerza_salto = -impulso * 0.9
	
func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote
	
func caida_al_vacio():
	if position.y > camara.limit_bottom:
		respawn()
		
func volar():
	timer_volar.start()
	acel_caida = acel_caida_power_up
	animationPlayer.play("volar")
	saltar_movimiento()
	
func respawn():
	PlayerInfo.restar_vidas()
	PlayerInfo.reset_monedas()
	animationPlayer.play("oscurecer")
	if PlayerInfo.vidas >= 1:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


func _on_EnfriamientoPowerUp_timeout():
	fuerza_salto = fuerza_salto_original


func _on_EnfriamientoPoweUpFly_timeout():
	animationPlayer.play("default")
	acel_caida = acel_caida_original
	
func play_entrar_portal(posicion_portal):
	puede_moverse = false
	animationPlayer.play("entrar_portal")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
		)
	$Tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animationPlayer.play("oscurecer")
		
func danio_player(danio):
	salud -= danio
	if salud <= 0:
		respawn()

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("daño"):
		danio_player(area.get_parent().danio)
