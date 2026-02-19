extends Area2D

@export var dialog_key: String = ""
@onready var key_hint: TextureRect = $KeyHint
var area_active: bool

func _on_ready() -> void:
	area_active = false
	key_hint.visible = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignalBus.display_simple_dialog.emit(dialog_key)

func _on_area_entered(_area: Area2D) -> void:
	set_area_active(true)

func _on_area_exited(_area: Area2D) -> void:
	set_area_active(false)

func set_area_active(flag: bool) -> void:
	self.area_active = flag
	key_hint.visible = flag
