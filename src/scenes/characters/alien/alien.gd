class_name Alien extends BaseCharacter

@onready var animation_player_w: AnimationPlayer = $AnimationPlayerWrite


func _physics_process(_delta: float) -> void:
		#if animations.current_animation.contains("walk"):
			#animations.stop()
		#return
	
	#handle_input()
	move_and_slide()
	#update_animations()
