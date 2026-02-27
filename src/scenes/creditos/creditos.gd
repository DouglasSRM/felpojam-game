extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var camera_inicial: float
var moto_inicial: float

var tempo_acumulado := 0.0
const INTERVALO := 0.01

var subir: bool = false

func move_frame():
	camera.offset.y += 0.5

func _ready():
	camera_inicial = camera.offset.x
	await Utils.sleep(2)
	subir = true

func finalizar():
	Global.jogo_iniciou = false
	Global.cena_2_pos_carimbo = false
	Global.pos_carimbo_4 = false
	Global.permite_finalizar = true
	SceneManager.change_scene(self, "main_menu")

func _process(delta: float) -> void:
	if subir:
		if (camera.offset.y >= 2150):
			subir = false
			return
		
		tempo_acumulado += delta
		if tempo_acumulado >= INTERVALO:
			tempo_acumulado = 0.0
			move_frame()

func _on_button_pressed() -> void:
	finalizar()
