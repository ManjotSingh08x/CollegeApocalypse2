extends StaticBody2D

const DEFAULT_CHEST = preload("res://Assets/Chest/default_chest.png")
const HIGHLIGHTED_CHEST = preload("res://Assets/Chest/highlighted_chest.png")
const OPEN_CHEST = preload("res://Assets/Chest/open_chest.png")
@onready var texture_rect = $TextureRect
@onready var inventory = $Inventory
@onready var chest_icon: Area2D = $Inventory/ChestIcon

@export var coins_present = 10

var interactable = false

func _ready():
	chest_icon.coins = coins_present
	texture_rect.texture = DEFAULT_CHEST
	interactable = false
	
func _on_interactive_zone_body_entered(body):
	texture_rect.texture = HIGHLIGHTED_CHEST
	interactable = true

func _input(event):
	if event.is_action_pressed("interact") and interactable:
		if inventory.visible:
			texture_rect.texture = HIGHLIGHTED_CHEST
			inventory.close()
		else:
			texture_rect.texture = OPEN_CHEST
			inventory.open()
func _on_interactive_zone_body_exited(body):
	texture_rect.texture = DEFAULT_CHEST
	interactable = false
	inventory.close()
	
func chest(): pass
	
