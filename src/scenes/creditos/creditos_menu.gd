extends Creditos

func _ready():
	step = 1
	wait = 1
	carimbao = false
	super()

func _process(delta: float) -> void:
	if subir:
		if (camera.offset.y >= 2000):
			subir = false
			return
	super(delta)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		finalizar()
