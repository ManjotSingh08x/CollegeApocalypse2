extends Node2D
@onready var interactive_zone: Area2D = $InteractiveZone
@onready var trader_inventory: Area2D = $TraderInventory

@export var coins_present = 10

var interactable = false

func _ready():
	interactable = false
	
func _on_interactive_zone_body_entered(body):
	interactable = true

func _input(event):
	if event.is_action_pressed("interact") and interactable:
		if trader_inventory.visible:
			trader_inventory.close()
		else:
			trader_inventory.open()
			
func _on_interactive_zone_body_exited(body):
	interactable = false
	trader_inventory.close()
	
func trader(): pass
	



func _on_left_switch_pressed () -> void:
	pass # Replace with function body.
