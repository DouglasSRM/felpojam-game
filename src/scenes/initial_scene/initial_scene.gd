extends Node2D

@onready var simple_dialog_player: CanvasLayer = $SimpleDialogPlayer


func _on_ready() -> void:
	simple_dialog_player.visible = true
