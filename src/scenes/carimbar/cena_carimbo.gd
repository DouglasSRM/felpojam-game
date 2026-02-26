extends Node2D

#@onready var carimbar: GameCarimbo = $Carimbar

func _ready() -> void:
	var carimbar: Node2D
	
	carimbar = load("res://src/scenes/carimbar/carimbar_1.tscn").instantiate()
	add_child(carimbar)
	carimbar.terminou.connect(Callable(self, "terminou"))

func terminou():
	Global.cena_2_pos_carimbo = true
	SceneManager.pop_scene()

func _on_button_pressed() -> void:
	terminou()
