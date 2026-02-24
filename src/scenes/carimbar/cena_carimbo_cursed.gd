extends Node2D

func _ready() -> void:
	var carimbar: Node2D
	
	carimbar = load("res://src/scenes/carimbar/carimbar_2.tscn").instantiate()
	add_child(carimbar)
	carimbar.terminou.connect(Callable(self, "terminou"))

func terminou():
	SceneManager.change_scene(self, "cena_4")
