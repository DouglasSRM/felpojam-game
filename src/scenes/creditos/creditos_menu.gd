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
