class_name Cutscene2 extends Node2D

@onready var sprite_1: Sprite2D = $CanvasLayer/Sprite1
@onready var sprite_2: Sprite2D = $CanvasLayer/Sprite2

func _ready():
	sprite_1.visible = true
	sprite_2.visible = false
	await Utils.sleep(2)
	SceneManager.transition_effect.visible = true
	SceneManager.animation_player.play("transition_out")
	await SceneManager.animation_player.animation_finished
	sprite_1.visible = false
	sprite_2.visible = true
	SceneManager.animation_player.play("transition_in")
	await Utils.sleep(5)
	SceneManager.transition_effect.visible = false
	SceneManager.change_scene_weep(self, "cena_casa_3/cena_casa_3")
