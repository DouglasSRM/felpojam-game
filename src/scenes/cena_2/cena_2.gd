extends BaseScene

func _ready() -> void:
	super()
	
	player.animations.play("walk_down")

func carimbar():
	SceneManager.push_scene("carimbar/cena_carimbo")
