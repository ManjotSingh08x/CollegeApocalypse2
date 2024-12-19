#TODO: add path to chest json
#TODO: add the default json in the form of a resource 
extends Area2D
const SlotClass = preload("res://Scripts/slot.gd")
const ItemClass = preload("res://Scenes/item.tscn")
@export var chest_id: String = ''
@onready var inventory_slots = $GridContainer
var holding_item = null
var NUM_INVENTORY_SLOTS = 4
var inventory = {
	0: ["Sword", 1], #----> slot_index: [item_name, item_quantitiy]
	1: ["Apple", 75],
	2: ["Apple", 45],
	3: ["Stick", 3],
}

	
func _on_clear_holding_item():
	remove_child(holding_item)
	holding_item = null


func _ready():
	var slots = inventory_slots.get_children()
	InHand.connect("clear_holding_item", Callable(self, "_on_clear_holding_item"))
	for i in range(slots.size()):
		slots[i].slot_index = i
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
	load_from_json()

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				item_quantity -= able_to_add
				
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func add_item_to_empty_slot(item, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	
func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)
	
func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
	
func update_slot_visual(slot_index, item_name, item_quantity):
	var slot= get_tree().root.get_node("Game/User_Interface/Inventory/GridContainer/Slot" + str(slot_index+1))
	if slot.item != null:
		slot.item.set_item(item_name, item_quantity)
	else:
		slot.initialize_item(item_name, item_quantity)
	
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if inventory.has(i):
			slots[i].initialize_item(inventory[i][0], inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		# Left click was used
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			# Currently holding an item
			if InHand.holding_item != null:
				# Empty slot
				if !slot.item:
					left_click_empty_slot(slot)
				# Slot already contains an item
				else:
					# Different item, so swap
					if InHand.holding_item.item_name != slot.item.item_name:
						left_click_diff_item(event, slot)
					# Same item, so try to merge
					else:
						left_click_same_item(slot)
			# Not holding an item
			elif slot.item and InHand.holding_item == null:

				left_click_not_holding(slot)
		# Right click was used
		elif event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			if slot.item and InHand.holding_item == null:
				right_click_not_holding(slot)
			elif slot.item and InHand.holding_item.item_name == slot.item.item_name:
				right_click_holding(slot)

func _input(event):
	if InHand.holding_item and holding_item:
		holding_item.global_position = get_global_mouse_position()
		
func left_click_empty_slot(slot):
	slot.putIntoSlot(InHand.holding_item)
	add_item_to_empty_slot(InHand.holding_item, slot)
	slot.item.parent_slot = slot
	InHand.holding_item = null
	InHand.prev_inv.holding_item = null

					
func left_click_diff_item(event, slot):
	# Temporarily store the item in the slot
	var temp_item = slot.item
	var temp_inventory_data = inventory[slot.slot_index]

	# Remove the item from the current slot
	remove_item(slot)
	slot.remove_child(slot.item)
	slot.refresh_style()

	# Place the currently held item into the slot
	slot.putIntoSlot(InHand.holding_item)
	add_item_to_empty_slot(InHand.holding_item, slot)
	

	# Set the temporarily stored item as the holding item
	holding_item = temp_item
	InHand.holding_item = temp_item
	add_child(InHand.holding_item)
	holding_item.global_position = get_global_mouse_position()

	# Update the inventory data with the swapped item
	inventory[slot.slot_index] = temp_inventory_data
	## giving error
	#remove_item(slot)
	#add_item_to_empty_slot(holding_item, slot)
	#var temp_item = slot.item
	#slot.remove_child(slot.item)
	##PlayerInv.holding_item = item
	##inventoryNode.add_child(PlayerInv.holding_item)
	##item = null
	#slot.refresh_style()
	#temp_item.global_position = event.global_position
	#slot.putIntoSlot(holding_item)
	#holding_item = temp_item
	#add_child(holding_item)
	#holding_item.global_position = get_global_mouse_position()
	
func left_click_same_item(slot):
	#working properly
	#print("merging items")
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= InHand.prev_inv.holding_item.item_quantity:
		add_item_quantity(slot, InHand.prev_inv.holding_item.item_quantity)
		slot.item.add_item_quantity(InHand.prev_inv.holding_item.item_quantity)
		InHand.prev_inv.holding_item.queue_free()
		InHand.prev_inv.holding_item = null
		InHand.holding_item = null
	else:
		add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)
		InHand.holding_item = holding_item
		
func left_click_not_holding(slot: SlotClass):
	remove_item(slot)
	InHand.prev_inv = self
	InHand.prev_inv.holding_item = slot.item
	InHand.holding_item = slot.item
	#add_child(PlayerInv.holding_item)
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()
	
func right_click_not_holding(slot: SlotClass):
	#working properly
	if slot.item.item_quantity == 1:
		left_click_not_holding(slot)
	else:
		slot.item.decrease_item_quantity(1)
		add_item_quantity(slot, -1)
		holding_item = ItemClass.instantiate()
		InHand.holding_item = holding_item
		InHand.prev_inv = self
		holding_item.set_item(slot.item.item_name, 1, slot)
		add_child(holding_item)
		holding_item.global_position = get_global_mouse_position()
		#print(PlayerInv.inventory)

func right_click_holding(slot: SlotClass):
	#working properly
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	if InHand.prev_inv.holding_item.item_quantity < stack_size:
		if slot.item.item_quantity == 1:
			remove_child(slot)
			slot.remove_child(slot.item)
			slot.item = null
			#print(holding_item.item_name)
			InHand.prev_inv.holding_item.set_item(InHand.prev_inv.holding_item.item_name, InHand.prev_inv.holding_item.item_quantity+1, slot)
			slot.refresh_style()
		else:
			add_item_quantity(slot, -1)
			slot.item.add_item_quantity(-1)
			InHand.prev_inv.holding_item.set_item(InHand.prev_inv.holding_item.item_name, InHand.prev_inv.holding_item.item_quantity+1,slot)
			
func open():

	self.visible = !self.visible 
	
func close():

	self.visible = false
		

func close_inv():
	pass
	#TODO: if the player has any item in the hand, put it in an empty slot

	
	
func load_from_json():
	#TODO: create functionality to load from json file
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if inventory.has(i):
			slots[i].initialize_item(inventory[i][0], inventory[i][1])
	
func save_to_json():
	#TODO: create functionality to save to json, if the file is empty, 
	#fill it with default items
	#add a seperate entry in the dictionary for the state of the chest
	pass
	
func reset():
	#TODO: add a button to fill the chest to resetthe contents
	pass
	
func close_chest():
	#TODO: save the state and close the invnetory system. change the textures and if player has item in hand, put it in an empty slot
	pass
