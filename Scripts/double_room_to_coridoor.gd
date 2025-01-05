extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	change_scene()

func change_scene():
	if global.transition_scene4 == true:
		if Input.is_action_pressed("move_left"):
			get_tree().change_scene_to_file("res://Scenes/coridoor.tscn")
			global.finish_transition(global.transition_scene4)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene4 = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene4 = false
