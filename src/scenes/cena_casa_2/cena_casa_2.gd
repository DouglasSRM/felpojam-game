class_name CenaCasa2 extends InitialScene

func _ready():
	gustavo.global_position = Vector2(9999,9999)
	Global.jogo_iniciou = true
	super()

func deitar():
	super()

	SceneManager.change_scene_circle(self, "carimbar/cena_carimbo_cursed")
