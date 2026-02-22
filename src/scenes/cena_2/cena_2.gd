extends BaseScene

func _ready() -> void:
	super()
	
	player.animations.play("walk_down")

func carimbar():
	SceneManager.push_scene("carimbar/cena_carimbo")

func armario_uniforme():
	player.can_move = false
	
	var tempo: float = 0.8
	var player_original_pos = player.global_position
	var player_armario = Vector2(player_original_pos.x, player_original_pos.y-50)
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(player, "global_position", player_armario, tempo) 
	SceneManager.fade_in()
	await tween.finished
	
	await Utils.sleep(0.2)
	player.trocar_uniforme()
	SceneManager.fade_out()
	player.animations.play("walk_down")
	var tween2: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween2.tween_property(player, "global_position", player_original_pos, tempo) 
	await tween2.finished
	player.can_move = true
