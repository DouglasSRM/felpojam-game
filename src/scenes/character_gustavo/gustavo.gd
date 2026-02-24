class_name Gustavo extends BaseCharacter

@onready var animation_player_w: AnimationPlayer = $AnimationPlayerW

func _ready() -> void:
	pass
	self.animation_player = animation_player_w
	#animation_player.play("walk_down")
