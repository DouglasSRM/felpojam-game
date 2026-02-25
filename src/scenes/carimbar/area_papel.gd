class_name AreaPapel extends Area2D

@onready var sprite: Sprite2D = $SpritePapel
@onready var marca: Sprite2D = $marca

func _ready() -> void:
	marca.visible = false

func carimbar():
	marca.visible = true
