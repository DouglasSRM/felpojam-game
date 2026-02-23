extends BaseScene


func carimbar():
	SceneManager.push_scene("carimbar/cena_carimbo")


func _on_tree_entered() -> void:
	if Global.pos_carimbo_4:
		cena_pos_carimbo()

func cena_pos_carimbo():
	await Utils.sleep(2)
	SceneManager.animation_player.play("escuro")
