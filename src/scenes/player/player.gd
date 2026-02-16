class_name Player extends CharacterBody2D

@export var speed: int = 150
@onready var animations: AnimationPlayer = $AnimationPlayer

var walking: bool = false

func handle_input():
	var moveDirection: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	walking = (moveDirection == Vector2(0,0))
	velocity = moveDirection*speed

func update_animations():
	var direction = ""

	if velocity.x < 0: direction = "left"
	elif velocity.x > 0: direction = "right"
	elif velocity.y < 0: direction = "up"
	elif !walking: direction = "down"
	
	if direction != "":
		animations.play("walk_"+direction)
	else:
		animations.stop()

func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	update_animations()
