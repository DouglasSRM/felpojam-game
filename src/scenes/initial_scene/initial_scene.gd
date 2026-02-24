class_name InitialScene extends BaseScene

@onready var simple_dialog_player: CanvasLayer = $SimpleDialogPlayer
@onready var interacao_cama: Area2D = $InteracaoCama
@onready var dialogo_gustavo: Area2D = $Dialogos/DialogoGustavo

const player_deitada = Vector2(56,130)

var deitada: bool = false

var player_collision_layer
var player_collision_mask

var pode_deitar: bool = true
@onready var gustavo: CharacterBody2D = $Gustavo

func _ready() -> void:
	super()
	if !Global.jogo_iniciou:
		Global.jogo_iniciou = true
		set_status_inicial()
		await Utils.sleep(1)
		dialogo_gustavo._activate_dialogue()
		await Utils.sleep(0.5)
		await levantar("scream", 0.5)
		interacao_cama.visible = true


func set_status_inicial():
	player.global_position = player_deitada
	set_player_dormindo()
	player.animations.play("sleeping")
	interacao_cama.visible = false
	deitada = true


func set_player_dormindo():
	player.can_move = false
	player_collision_layer = player.collision_layer
	player_collision_mask = player.collision_mask
	player.collision_layer = 0
	player.collision_mask = 0

func _on_ready() -> void:
	simple_dialog_player.visible = true

func interagir_cama() -> void:
	if !pode_deitar:
		return
	
	pode_deitar = false
	
	if !deitada:
		await deitar()
	else:
		await levantar("scream", 0.5)
		player.can_move = true
	deitada = !deitada
	
	await Utils.sleep(0.1)
	pode_deitar = true

func deitar():
	set_player_dormindo()
	await Utils.tween_meio_circulo(player, player_deitada, true, 0.8)
	player.animations.play("sleeping")


func levantar(animation: String, wait_time: float):
	player.animations.play(animation)
	await Utils.sleep(wait_time)
	await Utils.tween_meio_circulo(player, Vector2(98,160), false, 0.8)
	player.collision_layer = player_collision_layer
	player.collision_mask = player_collision_mask


func ler_livro():
	for livro in get_tree().get_nodes_in_group("livro"):
		#livro.terminou_de_ler.emit()
		return
	
	var cena_livro: LeituraDeLivro = load("res://src/scenes/livro/leitura_de_livro.tscn").instantiate()
	player.can_move = false
	
	cena_livro.livro_path = "res://assets/livro/a_carimbada/livro_em_ordem.png"
	cena_livro.paginas = 11
	
	self.add_child(cena_livro)
	cena_livro.add_to_group("livro")
	await cena_livro.terminou_de_ler
	
	self.remove_child(cena_livro)
	player.can_move = true
	
