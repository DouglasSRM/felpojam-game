extends CanvasLayer


var player: Player

var scene_dir_path = "res://src/scenes/"

@onready var pause_menu = preload("res://src/scenes/pause_menu/pause_menu.tscn").instantiate()

@onready var transition_effect: ColorRect = $transition_effect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
	if from.has_node("Player"):
		player = from.player
		player.get_parent().remove_child(player)
	
	animation_player.play("transition_out")
	await animation_player.animation_finished
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	animation_player.play("transition_in")
