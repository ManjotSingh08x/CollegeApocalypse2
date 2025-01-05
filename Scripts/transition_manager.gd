extends Node

var transition_scene1 = false
var transition_scene2 = false
var transition_scene3 = false
var transition_scene4 = false

var player_current_attack = false
var player_pos = Vector2(0,0)

func finish_transition(transition_scene):
	if transition_scene == true:
		transition_scene = false
