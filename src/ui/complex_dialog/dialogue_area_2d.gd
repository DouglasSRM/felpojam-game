extends Area2D

const dialogue_system_preload = preload("res://src/ui/complex_dialog/dialogue_system.tscn")

@export var activate_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(240, 48)
var dialogue_bottom_pos: Vector2 = Vector2(240, 220)

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

var player_node: CharacterBody2D = null

func _ready():
	set_player_reference()

func _process(_delta: float) -> void:
	if !player_node:
		set_player_reference()
		return
	
	if !activate_instant and player_body_in:
		if only_activate_once and has_activated_already:
			set_process(false)
			return
		
		if Input.is_action_just_pressed("E"):
			_activate_dialogue()
			has_activated_already = true
			player_body_in = false

func set_player_reference():
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _activate_dialogue() -> void:
	if player_node:
		player_node.can_move = false
	
	var new_dialogue = dialogue_system_preload.instantiate()
	if override_dialogue_position:
		desired_dialogue_pos = override_position
	else:
		if (player_node.global_position.y > get_viewport().get_camera_2d().get_screen_center_position().y):
			desired_dialogue_pos = dialogue_top_pos
		else:
			desired_dialogue_pos = dialogue_bottom_pos
	new_dialogue.global_position = desired_dialogue_pos
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)

func _on_body_entered(body: Node2D) -> void:
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
		player_body_in = true
		if activate_instant:
			has_activated_already = true
			_activate_dialogue()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body_in = false
