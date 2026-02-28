class_name Livro extends Node2D

signal sair

@onready var sprite: Sprite2D = $VBoxContainer/Sprite
@onready var previous: Button = $VBoxContainer/HBoxContainer/Previous
@onready var next: Button = $VBoxContainer/HBoxContainer/Next

var path: String
var total_pages: int
var current_page: int

func _ready() -> void:
	current_page = 1
	previous.text = "   sair    "

func set_page():
	sprite.texture = load(path+'_'+str(current_page)+'.png')

func _on_previous_pressed() -> void:
	if current_page == 1:
		sair.emit()
		return
	
	if total_pages == current_page:
		next.text = "     >     "
	
	current_page -= 1
	set_page()
	
	if current_page == 1:
		previous.text = "   sair    "

func _on_next_pressed() -> void:
	if total_pages == current_page:
		sair.emit()
		return
	
	previous.text = "     <     "
	
	current_page += 1
	set_page()
	
	if total_pages == current_page:
		next.text = "   sair    "
