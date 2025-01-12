extends Area2D
@onready var item_switcher: Area2D = $ItemSwitcher
@onready var item_switcher_label: Label = $ItemSwitcher/Label
@onready var item_display: Area2D = $ItemDisplay
@onready var item_quantity: Area2D = $ItemQuantity
@onready var item_cost: Area2D = $ItemCost
@onready var item_display_texture_rect: Panel = $ItemDisplay/Panel
@onready var item_quantity_label: Label = $ItemQuantity/Label


const ItemClass = preload("res://Scenes/item.tscn")
var trader_inventory = [
	["Apple", 10],
	["Key", 1],
	["Stick", 3]
]
var display_item = null
var quantity_to_buy = 0
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display(index)
	refresh_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func open():
	self.visible = true
	
	
func close():
	self.visible = false
	pass
	
func display(item_index):
	print("displayed ", item_index)
	display_item = ItemClass.instantiate()
	remove_prev()
	add_the_child(display_item)
	display_item.set_item(trader_inventory[item_index][0], trader_inventory[item_index][1], item_display_texture_rect)

func add_the_child(item_to_add):
	item_display_texture_rect.add_child(item_to_add)
	item_to_add.parent_slot = item_display_texture_rect
	item_to_add.position.x += 12
	item_to_add.position.y += 12
	
func remove_prev():
	if len(item_display_texture_rect.get_children()) > 0:
		for child in item_display_texture_rect.get_children():
			if child.get_class() == ItemClass.instantiate().get_class():
				child.queue_free()

func _on_left_quantity_pressed() -> void:
	if quantity_to_buy > 0:
		quantity_to_buy -= 1
		item_quantity_label.text = str(quantity_to_buy)
	refresh_inventory()
		
func _on_right_quantity_pressed() -> void:
	if display_item:
		if quantity_to_buy < display_item.item_quantity:
			quantity_to_buy += 1
	refresh_inventory()
	
	
func _on_left_switch_pressed () -> void:
	var max_val = len(trader_inventory)
	if max_val:
		index = (index - 1 + max_val) % max_val
	refresh_inventory()
	
	


func _on_right_switch_pressed() -> void:
	var max_val = len(trader_inventory)
	if max_val:
		index = (index + 1) % max_val
	else:
		index = -1
	refresh_inventory()
	
func refresh_inventory():
	if display_item:
		item_quantity_label.text = str(quantity_to_buy)
	else:
		quantity_to_buy = 0
		item_quantity_label.text = ''
		
	if index > -1:
		display(index)
		item_switcher_label.text = trader_inventory[index][0]
