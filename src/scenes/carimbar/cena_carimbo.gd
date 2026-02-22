extends Node2D

@onready var carimbar: GameCarimbo = $Carimbar

func _ready() -> void:
	carimbar.terminou.connect(Callable(self, "terminou"))

func terminou():
	SceneManager.pop_scene()

func _on_button_pressed() -> void:
	terminou()
