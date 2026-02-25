class_name Cena7 extends BaseScene

@onready var dialogo_final: DialogArea = $Dialogos/DialogoFinal

func _ready():
	super()
	player.can_move = false
	await Utils.sleep(1)
	dialogo_final._activate_dialogue()
	await dialogo_final.dialogue_finished
	SceneManager.change_scene(self, "carimbar/cena_carimbo_final", false, true)
