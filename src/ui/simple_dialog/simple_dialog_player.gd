extends CanvasLayer

@export_file("*json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background: TextureRect = $Background
@onready var text_label: Label = $TextLabel

func _ready():
	background.visible = false
	text_label.text = ""
	scene_text = load_scene_text()
	SignalBus.display_simple_dialog.connect(Callable(self, "on_display_simple_dialog"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		FileAccess.open(scene_text_file, FileAccess.READ)
		return JSON.parse_string(FileAccess.get_file_as_string(scene_text_file))
	else:
		return {Error = ERR_BUG}

func on_display_simple_dialog(text_key: String):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

func show_text():
	text_label.text = selected_text.pop_front() #pop front retorna o primeiro elemento do array e também remove ele

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
