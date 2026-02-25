extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogo_moto_1: DialogArea = $CanvasLayer/DialogoMoto1

func _ready() -> void:
	animation_player.play("moto")
	await Utils.sleep(2)
	dialogo_moto_1._activate_dialogue()
	dialogo_moto_1.dialogue_finished.connect(Callable(self, "finalizar"))

func finalizar():
	SceneManager.change_scene(self, "cena_2")
