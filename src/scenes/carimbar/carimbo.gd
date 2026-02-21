class_name Carimbo extends Area2D

enum CarimboState {
	SEM_TINTA,
	COM_TINTA
}
@onready var sprite: Sprite2D = $SpriteCarimbo

var status: CarimboState

func _ready() -> void:
	status = CarimboState.SEM_TINTA
