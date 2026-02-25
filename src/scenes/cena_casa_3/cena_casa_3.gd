class_name CenaCasa3 extends InitialScene

@onready var dialogo_acordou: DialogArea = $Dialogos/DialogoAcordou
@onready var dialogo_dormir: DialogArea = $Dialogos/DialogoDormir

func _ready():
	interacao_cama.function_call = ""
	gustavo.global_position = Vector2(9999,9999)
	Global.jogo_iniciou = true
	super()
	player.can_move = false
	player.position = player_deitada
	set_player_dormindo()
	player.animations.play("sleeping")
	player.animations.stop()
	await Utils.sleep(0.8)
	player.animations.play("walk_down")
	await Utils.sleep(0.5)
	dialogo_acordou._activate_dialogue()
	await dialogo_acordou.dialogue_finished
	await levantar("walk_down")
	player.can_move = true
	interacao_cama.function_call = "deitar"

func sair():
	SceneManager.change_scene(self, "cena_6")

func cancelar():
	pass

func deitar():
	interacao_cama.function_call = ""
	dialogo_dormir._activate_dialogue()
	await dialogo_dormir.dialogue_finished
	await Utils.sleep(0.3)
	interacao_cama.function_call = "deitar"
