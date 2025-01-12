extends CharacterBody2D

const acc = 460
const max_speed = 225
var being_picked_up = false
var player = null
@onready var inventory = $"../Player/Inventory"

@export var sprite_texture: Texture2D
@export_enum("Stick", "Apple", "Sword", "Coin") var item_name: String
@export var coins: int = 0
@export var quantity: int = 1

func _ready():
	$Sprite2D.texture = sprite_texture

func _on_interactable_area_body_entered(body):
	print("something entered")
	print(body)
	if body.has_method("player"):
		print("player entered")
		player = body
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		
func _physics_process(delta):
	if being_picked_up == true:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction*max_speed,acc*delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 10:
			if item_name == "Coin":
				if player != null:
					player.user_interface.add_coins(coins)
			else:
				inventory.add_item(item_name, quantity)
			queue_free()
	move_and_slide()

func pick_up_item(body):
	player = body
	being_picked_up = true
	
func pickup():
	pass
		
		
