extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.player_pos!= Vector2(0,0):
		$"../Player".position = global_position + Vector2(0,5)

func _process(delta: float) -> void:
	change_scene()

func change_scene():
	if global.transition_scene2 == true:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://Scenes/SingleRoom.tscn")
			global.finish_transition(global.transition_scene2)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene2 = true
		global.player_pos = $"../Player".position


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene2 = false
