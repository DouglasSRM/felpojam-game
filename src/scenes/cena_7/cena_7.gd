class_name Cena7 extends BaseScene

@onready var dialogo_final: DialogArea = $Dialogos/DialogoFinal
@onready var cecilia: BaseCharacter = $Cecilia
@onready var secretaria: BaseCharacter = $Secretaria

func _ready():
	super()
	await cecilia.walk("right", 0.1, 0.1)
	cecilia.stop_walking(0)
	await Utils.sleep(0.5)
	move_cecilia()
	player.can_move = false
	player.animation_player.play("walk_right")
	secretaria.walk("left", 0, 0.01)
	secretaria.stop_walking(0)
	await Utils.sleep(0.5)
	dialogo_final._activate_dialogue()
	await Utils.sleep(1)
	move_player()
	await dialogo_final.dialogue_finished
	SceneManager.change_scene(self, "carimbar/cena_carimbo_final", false, true)

func move_player():
	player.walk("right", 60, 0.8)

func move_cecilia():
	await cecilia.walk("up", 60, 0.5)
	await cecilia.stop_walking(0.1)
	await cecilia.walk("left", 60, 4)
	cecilia.global_position = Vector2(9999,9999)
