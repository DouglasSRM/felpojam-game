extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

#func ready():
	#animation_player.play("moto")

func _process(_delta: float) -> void:
	if !animation_player.is_playing():
		animation_player.play("moto")
