class_name GameCarimbo extends Node2D

enum GameState {
	SEM_FOLHA,
	FOLHA_SEM_CARIMBO,
	FOLHA_CARIMBADA,
}

signal terminou

const pos_papel_hidden = Vector2(240, -100)
const pos_papel_shown  = Vector2(240, 100)

@onready var button: Button = $Button
@onready var papel: Area2D = $Papel
@onready var carimbo: Carimbo = $Carimbo
@onready var carimbeira: Area2D = $Carimbeira
@onready var dialogos: Node2D = $Dialogos

@export var total_tickets: int
@export var prefixo_tickets: String

var carimbo_starter_position: Vector2
var current_ticket: int = 0
var arrastando: bool = false
var offset: Vector2 = Vector2.ZERO
var papel_atual: AreaPapel
var state: GameState
var timer_carimbo: Timer

func set_timer():
	timer_carimbo = Timer.new()
	timer_carimbo.wait_time = 10
	timer_carimbo.autostart = false
	timer_carimbo.one_shot = false
	timer_carimbo.timeout.connect(_on_timer_timeout)
	add_child(timer_carimbo)
	
	timer_carimbo.stop()

func _on_timer_timeout():
	carimbo.position = carimbo_starter_position
	release_carimbo()

func diaologo(tempo: float):
	for d in dialogos.get_children():
		if d is DialogArea and d.name == str(current_ticket):
			d._activate_dialogue()
			await d.dialogue_finished
			return
	if tempo:
		await Utils.sleep(tempo)

func _ready():
	carimbo_starter_position = carimbo.position
	set_timer()
	button.visible = false
	set_game_state(GameState.SEM_FOLHA)
	current_ticket += 1
	await Utils.sleep(1)
	await diaologo(0)
	chamar_ticket()

func set_game_state(p_state: GameState):
	self.state = p_state
	match state:
		GameState.SEM_FOLHA:
			button.text = "Folha"
		GameState.FOLHA_SEM_CARIMBO:
			button.text = ""
		GameState.FOLHA_CARIMBADA:
			button.text = "Entregar"
			button.visible = true

func chamar_ticket():
	papel.sprite.texture = load("res://assets/minigames/"+prefixo_tickets+"_"+str(current_ticket)+".png")
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
	await diaologo(0.5)
	if current_ticket <= total_tickets:
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
	timer_carimbo.start()

func release_carimbo():
	timer_carimbo.start()
	arrastando = false
	carimbo.sprite.frame = 0
	if carimbo.overlaps_area(carimbeira):
		carimbo.status = Carimbo.CarimboState.COM_TINTA
		return
	if carimbo.overlaps_area(papel_atual):
		if carimbo.status == Carimbo.CarimboState.COM_TINTA:
			papel_atual.carimbar()
			carimbo.status = Carimbo.CarimboState.SEM_TINTA
			set_game_state(GameState.FOLHA_CARIMBADA)

func _process(_delta: float) -> void:
	if arrastando:
		carimbo.global_position = get_global_mouse_position() + offset
