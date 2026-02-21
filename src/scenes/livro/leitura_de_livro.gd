class_name LeituraDeLivro extends Node2D

signal terminou_de_ler

@onready var livro: Livro = $Livro

var livro_path: String
var paginas: int

func _ready():
	livro.sprite.texture = load(livro_path)
	livro.sprite.hframes = paginas
	livro.sair.connect(Callable(self, "_on_sair"))

func _on_sair():
	terminou_de_ler.emit()
