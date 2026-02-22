extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogo_cutscene: DialogArea = $DialogoCutscene

func _ready():
	animation_player.play("temp")
	await Utils.sleep(3)
	dialogo_cutscene._activate_dialogue()
	await dialogo_cutscene.dialogue_finished
	SceneManager.change_scene(self, "initial_scene", false)
