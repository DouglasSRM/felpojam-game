extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func ready():
	animation_player.play("moto")
