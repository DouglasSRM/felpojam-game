extends MainMenu

func _ready() -> void:
	super()
	audio_stream_player.process_mode = audio_stream_player.ProcessMode.PROCESS_MODE_DISABLED

func _on_visibility_changed() -> void:
	if self.visible:
		if play:
			play.text = "Continuar"
		
		if settings_menu:
			settings_menu.visible = false

func _on_play_pressed() -> void:
	SceneManager.toggle_pause()
