extends Node2D

enum GameState {
	SEM_FOLHA,
	FOLHA_SEM_CARIMBO,
	FOLHA_CARIMBADA,
}

const pos_papel_hidden = Vector2(250, -100)
const pos_papel_shown  = Vector2(250, 100)

@onready var button: Button = $Button
@onready var papel: Area2D = $Papel
@onready var carimbo: Carimbo = $Carimbo
@onready var carimbeira: Area2D = $Carimbeira

var arrastando: bool = false
var offset: Vector2 = Vector2.ZERO

var papel_atual: Area2D

var state: GameState

func _ready():
	set_game_state(GameState.SEM_FOLHA)

func set_game_state(p_state: GameState):
	self.state = p_state
	match state:
		GameState.SEM_FOLHA:
			button.text = "Folha"
			button.visible = true
		GameState.FOLHA_SEM_CARIMBO:
			button.text = ""
			button.visible = false
		GameState.FOLHA_CARIMBADA:
			button.text = "Enviar"
			button.visible = true

func _on_button_pressed() -> void:
	if state == GameState.SEM_FOLHA:
		papel_atual = papel.duplicate()
		add_child(papel_atual)
		move_child(papel_atual, 0)
		var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(papel_atual, "global_position", pos_papel_shown, 0.8)
		
		set_game_state(GameState.FOLHA_SEM_CARIMBO)
	
	if state == GameState.FOLHA_CARIMBADA:
		button.visible = false
		var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(papel_atual, "global_position", pos_papel_hidden, 0.8)
		await tween.finished
		remove_child(papel_atual)
		set_game_state(GameState.SEM_FOLHA)
		

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
