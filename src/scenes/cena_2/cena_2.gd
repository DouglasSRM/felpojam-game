class_name Cena2 extends BaseScene

@onready var chefe: BaseCharacter = $Chefe
@onready var dialogo_gustavo: DialogArea = $Dialogos/DialogoGustavo
@onready var gustavo: Gustavo = $Gustavo
@onready var nao_trocou_uniforme: DialogArea = $Dialogos/NaoTrocouUniforme
@onready var minigame: Interactable = $Minigame
@onready var interacao_uniforme: Interactable = $InteracaoUniforme
@onready var dialogo_uniforme_2: DialogArea = $Dialogos/DialogoUniforme2
@onready var scene_trigger_to_3: SceneTrigger = $SceneTriggerTo3
@onready var npcs: Node2D = $Npcs
@onready var porta_fechada: TileMapLayer = $TileMaps/PortaFechada
@onready var armario_aberto: TileMapLayer = $TileMaps/ArmarioAberto
@onready var dialogo_pos_minigame: DialogArea = $Dialogos/DialogoPosMinigame

var player_position_failsafe := Vector2(160,155)
var trocou_uniforme: bool = false

signal libera_movimento
signal gustavo_saiu

func cena_2_pos_carimbo():
	minigame.function_call = ""
	dialogo_uniforme_2.visible = true
	interacao_uniforme.visible = true
	trocou_uniforme = false
	porta_fechada.visible = false
	
	scene_trigger_to_3.enabled = false
	for i in npcs.get_children():
		i.visible = false
	player.global_position = player_position_failsafe
	interacao_uniforme.function_call = "armario_uniforme"
	dialogo_pos_minigame._activate_dialogue()

func _ready() -> void:
	super()
	porta_fechada.visible = false
	armario_aberto.visible = false
	player.animations.play("walk_down")

func carimbar():
	if !trocou_uniforme:
		minigame.function_call = ""
		nao_trocou_uniforme._activate_dialogue()
		await nao_trocou_uniforme.dialogue_finished
		await Utils.sleep(0.5)
		minigame.function_call = "carimbar"
		return
	player_position_failsafe = player.global_position
	SceneManager.push_scene("carimbar/cena_carimbo")

func armario_uniforme():
	if trocou_uniforme:
		return
	interacao_uniforme.function_call = ""
	armario_aberto.visible = true
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
	trocou_uniforme = true
	interacao_uniforme.visible = false
	interacao_uniforme.set_area_active(false)
	armario_aberto.visible = false
	dialogo_uniforme_2.visible = false
	if Global.cena_2_pos_carimbo:
		scene_trigger_to_3.enabled = true

func after_dialogo_chefe():
	await chefe_sai_de_cena()
	dialogo_gustavo._activate_dialogue()
	await dialogo_gustavo.dialogue_finished
	libera_movimento.emit()

func gustavo_sai_de_cena():
	await player.walk("down", 90, 0.2)
	await gustavo.walk("left", 60, 0.6)
	await gustavo.walk("up", 60, 0.6)
	gustavo.global_position = Vector2(9999,9999)
	await Utils.sleep(0.1)
	porta_fechada.visible = true
	await Utils.sleep(0.1)
	gustavo_saiu.emit()

func chefe_sai_de_cena():
	await chefe.walk("right", 60, 1.5)
	await chefe.stop_walking(0.2)
	await chefe.walk("up", 60, 0.8)
	await chefe.stop_walking(0.2)
	await chefe.walk("right", 60, 1)
	await chefe.stop_walking(0.2)
	await chefe.walk("down", 60, 1.1)
	await chefe.stop_walking(0.2)
	await chefe.walk("right", 80, 2.2)
	await chefe.stop_walking(0.2)
	await chefe.walk("up", 80, 1.2)
	chefe.global_position = Vector2(9999,9999)
	await Utils.sleep(1)

func _on_tree_entered() -> void:
	if Global.cena_2_pos_carimbo:
		cena_2_pos_carimbo()
