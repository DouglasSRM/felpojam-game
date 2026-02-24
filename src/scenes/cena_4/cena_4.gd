extends BaseScene

@onready var alien: Alien = $Alien
@onready var dialogo_alien: DialogArea = $Dialogos/DialogoAlien

func carimbar():
	SceneManager.push_scene("carimbar/cena_carimbo")

func _ready() -> void:
	player.can_move = false
	await Utils.sleep(1)
	alien.velocity = Vector2(-20,0)
	alien.animation_player_w.play("walk_left_slow")
	await Utils.sleep(1.5)
	player.animations.play("walk_right")
	await Utils.sleep(2)
	alien.velocity = Vector2(0,0)
	alien.animation_player_w.stop()
	dialogo_alien._activate_dialogue()
	await dialogo_alien.dialogue_finished
	alien.velocity = Vector2(-5,0)
	await Utils.sleep(0.5)
	alien.velocity = Vector2(0,0)


func _on_tree_entered() -> void:
	if Global.pos_carimbo_4:
		cena_pos_carimbo()

func cena_pos_carimbo():
	await Utils.sleep(2)
	SceneManager.animation_player.play("escuro")
