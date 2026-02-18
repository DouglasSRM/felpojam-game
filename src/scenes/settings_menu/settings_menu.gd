extends Panel

@onready var fullscreen_cb: CheckButton = $settings_menu/fullscreen_cb

func _on_fullscreen_cb_toggled(toggled_on: bool) -> void:
	var window_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED  
	DisplayServer.window_set_mode(window_mode)


func _on_close_btn_pressed() -> void:
	self.visible = false


func _on_visibility_changed() -> void:
	if fullscreen_cb:
		fullscreen_cb.button_pressed = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)
