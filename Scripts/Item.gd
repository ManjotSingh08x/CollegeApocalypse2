extends Node2D
var item_name
var item_quantity
var parent_slot = null


# Called when the node enters the scene tree for the first time.
	
		
func add_item_quantity(amount):
	item_quantity += amount
	$Label.text = str(item_quantity)
	
func decrease_item_quantity(amount):
	item_quantity -= amount
	$Label.text = str(item_quantity)
	
func set_item(nm, qt, p_slot):
	item_name = nm
	item_quantity = qt
	parent_slot = p_slot
	$TextureRect.texture = load("res://Assets/ItemIcons/"+ item_name+".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)
