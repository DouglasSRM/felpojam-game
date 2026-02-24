extends Node2D

#@onready var carimbar: GameCarimbo = $Carimbar

func _ready() -> void:
	var carimbar: Node2D
	var cena: String
	if SceneManager.scene_stack[0].name == "Cena2":
		cena = "carimbar_1"
	elif SceneManager.scene_stack[0].name == "Cena4":
		cena = "carimbar_2"
	else:
		await Utils.sleep(0.1)
		terminou()
		return
	
	carimbar = load("res://src/scenes/carimbar/"+cena+".tscn").instantiate()
	add_child(carimbar)
	carimbar.terminou.connect(Callable(self, "terminou"))

func terminou():
	Global.cena_2_pos_carimbo = true
	SceneManager.pop_scene()

func _on_button_pressed() -> void:
	terminou()
