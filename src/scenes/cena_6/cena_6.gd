class_name Cena6 extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var moto: Sprite2D = $Moto

var camera_inicial: float
var moto_inicial: float

var tempo_acumulado := 0.0
const INTERVALO := 0.01

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

func _process(delta: float) -> void:
	tempo_acumulado += delta
	if tempo_acumulado >= INTERVALO:
		tempo_acumulado = 0.0
		move_frame()
