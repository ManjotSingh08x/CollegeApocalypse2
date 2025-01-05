extends Area2D
const TINY_CHEST_INV_FILLED = preload("res://Assets/InventoryAssets/tiny_chest_inv_filled.png")
const TINY_CHEST_INVENTORY_EMPTY = preload("res://Assets/InventoryAssets/tiny_chest_inventory_empty.png")
@onready var texture_rect: TextureRect = $TextureRect


var coins: int = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if coins > 0:
		texture_rect.texture = TINY_CHEST_INV_FILLED
	else:
		texture_rect.texture = TINY_CHEST_INVENTORY_EMPTY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	InHand.add_coins(coins)
	coins = 0
	texture_rect.texture = TINY_CHEST_INVENTORY_EMPTY
