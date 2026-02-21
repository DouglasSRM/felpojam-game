extends CanvasLayer

var scene_stack: Array[Node] = []

var player: Player
var trigger_name: String

var scene_dir_path = "res://src/scenes/"

@onready var pause_menu = preload("res://src/scenes/pause_menu/pause_menu.tscn").instantiate()

@onready var transition_effect: ColorRect = $transition_effect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func push_scene(scene: String):
	var full_path = scene_dir_path + scene +".tscn"
	var current = get_tree().current_scene
	if current:
		scene_stack.push_back(current)
		get_tree().root.remove_child(current)
	
	var new_scene = load(full_path).instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func pop_scene():
	if scene_stack.size() == 0:
		return
	
	var current = get_tree().current_scene
	if current:
		current.queue_free()
	
	var last = scene_stack.pop_back()
	get_tree().root.add_child(last)
	get_tree().current_scene = last

func _ready():
	add_child(pause_menu)
	pause_menu.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var origem: String = get_tree().current_scene.scene_file_path.get_file().get_basename()
		if origem != "main_menu":
			toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = get_tree().paused

func change_scene(from, to_scene_name: String) -> void:
	if from is BaseScene:
		player = from.player
		player.get_parent().remove_child(player)
	
	animation_player.play("carimbo_in")
	await animation_player.animation_finished
	
	var full_path = scene_dir_path + to_scene_name +"/"+to_scene_name+".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	animation_player.play("carimbo_out")
