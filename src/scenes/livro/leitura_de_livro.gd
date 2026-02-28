class_name LeituraDeLivro extends Node2D

signal terminou_de_ler

@onready var livro: Livro = $Livro

var livro_path: String
var paginas: int

func _ready():
	livro.path = livro_path
	livro.total_pages = paginas
	livro.set_page()
	livro.sair.connect(Callable(self, "_on_sair"))

func _on_sair():
	terminou_de_ler.emit()
