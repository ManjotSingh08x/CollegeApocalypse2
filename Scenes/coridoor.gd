extends Node2D

@onready var load_save: Node2D = $LoadSave

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_save.load_level()
	pass # Replace with function body.
	
func _exit_tree() -> void:
	load_save.save_level()
	pass
