class_name SceneTrigger extends Area2D

@export var connected_scene: String
var scene_folder = "res://src/scenes/"

func _on_body_entered(_body: Node2D) -> void:
	#var full_path = scene_folder + connected_scene + "/" + connected_scene + ".tscn"
	
	SceneManager.change_scene(self.owner, connected_scene)
	#get_tree().call_deferred("change_scene_to_file", full_path)
