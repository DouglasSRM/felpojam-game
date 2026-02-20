extends BaseScene

@onready var simple_dialog_player: CanvasLayer = $SimpleDialogPlayer

func _ready() -> void:
	super()
	player.animations.play("walk_down")

func _on_ready() -> void:
	simple_dialog_player.visible = true
