extends BaseScene

@onready var simple_dialog_player: CanvasLayer = $SimpleDialogPlayer

var deitada: bool = false

var player_collision_layer
var player_collision_mask

var pode_deitar: bool = true

func _ready() -> void:
	super()
	player.animations.play("walk_down")

func _on_ready() -> void:
	simple_dialog_player.visible = true

func interagir_cama() -> void:
	if !pode_deitar:
		return
	
	pode_deitar = false
	
	if !deitada:
		await deitar()
	else:
		await levantar()
	deitada = !deitada
	
	await get_tree().create_timer(0.1).timeout
	pode_deitar = true

func deitar():
	player.can_move = false
	player_collision_layer = player.collision_layer
	player_collision_mask = player.collision_mask
	player.collision_layer = 0
	player.collision_mask = 0
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(player, "global_position", Vector2(56,130), 0.8)
	await tween.finished
	player.animations.play("sleep")
	player.sprite_2d.frame = 17

func levantar():
	player.sprite_2d.frame = 0
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(player, "global_position", Vector2(98,160), 0.8)
	await tween.finished
	player.collision_layer = player_collision_layer
	player.collision_mask = player_collision_mask
	player.can_move = true
	player.animations.play("walk_down")
	player.animations.stop()
