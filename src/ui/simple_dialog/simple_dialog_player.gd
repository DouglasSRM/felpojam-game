extends CanvasLayer

@export_file("*json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false


func _ready():
	scene_text = load_scene_text()
	SignalBus.display_simple_dialog.connect(Callable(self, "on_display_simple_dialog"))

func load_scene_text():
	pass
	#if FileAccess.file_exists(scene_text_file):
		#FileAccess.open(scene_text_file, FileAccess.READ)
		#return JSON.parse_string(FileAccess.get_file_as_string(scene_text_file))
	#else:
		#return {Error = ERR_BUG}

func on_display_simple_dialog(text_key: String):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

func show_text():
	pass

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	#text_label.text = ""
	in_progress = false
	get_tree().paused = false
