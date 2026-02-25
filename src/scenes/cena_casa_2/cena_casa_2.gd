class_name CenaCasa2 extends InitialScene

@onready var dialogo_inicial_3: DialogArea = $Dialogos/DialogoInicial3

func _ready():
	gustavo.global_position = Vector2(9999,9999)
	Global.jogo_iniciou = true
	super()
	player.can_move = false
	await Utils.sleep(1)
	dialogo_inicial_3._activate_dialogue()
	await dialogo_inicial_3.dialogue_finished
	player.can_move = true

func deitar():
	super()

	SceneManager.change_scene_circle(self, "carimbar/cena_carimbo_cursed")
