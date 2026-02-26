extends Node2D

@onready var camera: Camera2D = $Camera2D

var camera_inicial: float
var moto_inicial: float

var tempo_acumulado := 0.0
const INTERVALO := 0.01

var subir: bool = false

func move_frame():
	camera.offset.y += 0.3

func _ready():
	camera_inicial = camera.offset.x
	#moto_inicial = moto.position.x
	#animation_player.play("moto")
	await Utils.sleep(2)
	subir = true
	await Utils.sleep(10)
	finalizar()

func finalizar():
	Global.jogo_iniciou = false
	Global.cena_2_pos_carimbo = false
	Global.pos_carimbo_4 = false
	Global.permite_finalizar = true
	SceneManager.change_scene(self, "main_menu")

func _process(delta: float) -> void:
	if subir:
		tempo_acumulado += delta
		if tempo_acumulado >= INTERVALO:
			tempo_acumulado = 0.0
			move_frame()
