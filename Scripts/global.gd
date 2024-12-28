extends Node

var transition_scene1 = false
var transition_scene2 = false
var transition_scene3 = false
var transition_scene4 = false


var player_current_attack = false
var player_pos = Vector2(0,0)

func finish_transition():
	if transition_scene1==true:
		transition_scene1= false

	if transition_scene2==true:
		transition_scene2 = false
		
	if transition_scene3==true:
		transition_scene3 = false
	
	if transition_scene4==true:
		transition_scene4 = false
