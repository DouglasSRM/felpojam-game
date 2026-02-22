class_name GameCarimbo extends Node2D

enum GameState {
	SEM_FOLHA,
	FOLHA_SEM_CARIMBO,
	FOLHA_CARIMBADA,
}

signal terminou

const pos_papel_hidden = Vector2(250, -100)
const pos_papel_shown  = Vector2(250, 100)
const total_tickets: int = 16

@onready var button: Button = $Button
@onready var papel: Area2D = $Papel
@onready var carimbo: Carimbo = $Carimbo
@onready var carimbeira: Area2D = $Carimbeira
@onready var dialogos: Node2D = $Dialogos

var current_ticket: int = 0
var arrastando: bool = false
var offset: Vector2 = Vector2.ZERO

var papel_atual: Area2D

var state: GameState

func diaologo():
	for d in dialogos.get_children():
		if d is DialogArea and d.name == str(current_ticket):
			d._activate_dialogue()
			await d.dialogue_finished
			return
	await Utils.sleep(1)

func _ready():
	button.visible = false
	set_game_state(GameState.SEM_FOLHA)
	await Utils.sleep(1)
	current_ticket += 1
	chamar_ticket()

func set_game_state(p_state: GameState):
	self.state = p_state
	match state:
		GameState.SEM_FOLHA:
			button.text = "Folha"
			#button.visible = true
		GameState.FOLHA_SEM_CARIMBO:
			button.text = ""
			#button.visible = false
		GameState.FOLHA_CARIMBADA:
			button.text = "Enviar"
			button.visible = true

func chamar_ticket():
	papel_atual = papel.duplicate()
	add_child(papel_atual)
	move_child(papel_atual, 0)
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(papel_atual, "global_position", pos_papel_shown, 0.8)
	
	set_game_state(GameState.FOLHA_SEM_CARIMBO)

func enviar_ticket():
	button.visible = false
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(papel_atual, "global_position", pos_papel_hidden, 0.8)
	await tween.finished
	remove_child(papel_atual)
	set_game_state(GameState.SEM_FOLHA)
	current_ticket += 1
	await diaologo()
	if current_ticket < total_tickets:
		chamar_ticket()
	else:
		terminou.emit()

func _on_button_pressed() -> void:
	if state == GameState.FOLHA_CARIMBADA:
		enviar_ticket()

func _on_carimbo_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			grab_carimbo()
		else:
			release_carimbo()
			
func grab_carimbo():
	arrastando = true
	carimbo.sprite.frame = 1
	offset = carimbo.global_position - get_global_mouse_position()

func release_carimbo():
	arrastando = false
	carimbo.sprite.frame = 0
	if carimbo.overlaps_area(carimbeira):
		carimbo.status = Carimbo.CarimboState.COM_TINTA
		return
	if carimbo.overlaps_area(papel_atual):
		if carimbo.status == Carimbo.CarimboState.COM_TINTA:
			papel_atual.sprite.frame = 1
			carimbo.status = Carimbo.CarimboState.SEM_TINTA
			set_game_state(GameState.FOLHA_CARIMBADA)

func _process(_delta: float) -> void:
	if arrastando:
		carimbo.global_position = get_global_mouse_position() + offset
