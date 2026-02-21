class_name Livro extends Node2D

signal sair

@onready var sprite: Sprite2D = $VBoxContainer/Sprite
@onready var previous: Button = $VBoxContainer/HBoxContainer/Previous
@onready var next: Button = $VBoxContainer/HBoxContainer/Next


func _ready() -> void:
	sprite.frame = 0
	previous.text = "   sair    "

func _on_previous_pressed() -> void:
	if sprite.frame == 0:
		sair.emit()
		return
	
	if sprite.hframes-1 == sprite.frame:
		next.text = "     >     "
	
	sprite.frame -= 1
	
	if sprite.frame == 0:
		previous.text = "   sair    "

func _on_next_pressed() -> void:
	if sprite.hframes-1 == sprite.frame:
		sair.emit()
		return
	
	previous.text = "     <     "
	
	sprite.frame += 1
	
	if sprite.hframes-1 == sprite.frame:
		next.text = "   sair    "
