class_name Cena6 extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var moto: Sprite2D = $Moto
@onready var animation_charpim: AnimationPlayer = $animation_charpim
@onready var dialogo_cena_6: DialogArea = $CanvasLayer/DialogoCena6

var camera_inicial: float
var moto_inicial: float

var tempo_acumulado := 0.0
const INTERVALO := 0.01

signal continuar

func pausa():
	await Utils.sleep(3)
	continuar.emit()

func move_frame():
	if moto.position.x == 1466:
		camera.offset.x = camera_inicial
		moto.position.x = moto_inicial
		return
	camera.offset.x += 1
	moto.position.x += 1

func _ready():
	camera_inicial = camera.offset.x
	moto_inicial = moto.position.x
	animation_player.play("moto")
	animation_charpim.play("charpim")
	await Utils.sleep(2)
	dialogo_cena_6._activate_dialogue()
	dialogo_cena_6.dialogue_finished.connect(Callable(self, "finalizar"))

func finalizar():
	SceneManager.change_scene(self,"cena_7")

func _process(delta: float) -> void:
	tempo_acumulado += delta
	if tempo_acumulado >= INTERVALO:
		tempo_acumulado = 0.0
		move_frame()
