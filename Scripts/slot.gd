extends Panel

var default_tex = preload('res://Assets/InventoryAssets/inv_slot.png')
var empty_tex = preload("res://Assets/InventoryAssets/empty_inv_slot.png")

var default_style:StyleBoxTexture = null
var empty_style: StyleBoxTexture = null


var ItemClass = preload("res://Scenes/item.tscn")
var item = null
var slot_index 
@onready var inventoryNode = find_parent("Inventory")


func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()
	
#func set_inv(inventory):
	#owner_inv = inventory
	
func refresh_style():
	if item == null:
		set('theme_override_styles/panel', empty_style)
	else:
		set('theme_override_styles/panel', default_style)

func pickFromSlot():
	remove_child(item)
	inventoryNode.holding_item = item
	inventoryNode.add_child(inventoryNode.holding_item)
	item = null
	refresh_style()

func putIntoSlot(new_item):
	inventoryNode.remove_child(new_item)
	InHand.emit_signal("clear_holding_item")
	item = new_item
	item.position = Vector2(0,0)
	add_the_child(item)
	refresh_style()

func pickOne():
	var new_item = ItemClass.instantiate()
	item.item_quantity -= 1
	new_item.set_item(item.item_name, 1, self)
	inventoryNode.add_child(new_item)
	refresh_style()

func add_the_child(item_to_add):
	add_child(item_to_add)
	item_to_add.parent_slot = self
	item_to_add.position.x += 9
	item_to_add.position.y += 9
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_the_child(item)
		item.set_item(item_name, item_quantity, self)
	else:
		item.set_item(item_name, item_quantity, self)
	refresh_style()
	
func remove_item():
	if item:
		remove_child(item)
	item = null
	refresh_style()
	
	

		
		
