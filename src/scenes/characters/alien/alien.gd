class_name Alien extends BaseCharacter

@onready var animation_player_w: AnimationPlayer = $AnimationPlayerWrite


func _physics_process(_delta: float) -> void:
	move_and_slide()
