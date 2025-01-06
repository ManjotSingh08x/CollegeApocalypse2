extends Node
@onready var room: Node2D = $".."
var SAVE_PATH: String
var children: Array[Node]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SAVE_PATH = "user://" + room.name + ".tres"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save_game"):
		check_test()
		save_level()
	if Input.is_action_just_pressed("load_game"):
		load_level()

func save_level():
	var saved_level: SaveLevel = SaveLevel.new()
	saved_level.level_name = room.name
	for child in room.get_children():
		if child.has_method("zombie"):
			save_zombie(saved_level, child)
		if child.has_method("chest"):
			save_chest(saved_level, child)
		if child.has_method("pickup"):
			save_pickup(saved_level, child)

	ResourceSaver.save(saved_level, SAVE_PATH)
	
func load_level():
	var saved_level: SaveLevel = ResourceLoader.load(SAVE_PATH)
	if saved_level == null:
		saved_level = SaveLevel.new()
	else:
		for child in room.get_children():
			if child.has_method("chest"):
				child.inventory.load_from_json(saved_level.chest_dict[child.name])
				print('manual setting first')
			if child.has_method('pickup'):
				if not saved_level.pick_up_dict.has(child.name):
					child.queue_free()
			if child.has_method('zombie'):
				if not saved_level.zombie_dict.has(child.name):
					child.queue_free()

func check_test():
	for child in room.get_children():
		if child.has_method('chest'):
			child.inventory.test = false
	
func save_chest(saved_level, child):
	saved_level.chest_dict[child.name] = child.inventory.output_json()

func save_pickup(saved_level: SaveLevel, child):
	print("saved ", child.name)
	saved_level.pick_up_dict[child.name] = {
		"item_name" : child.item_name,
		"global_position": child.global_position,
		"quantity": child.quantity,
		"coins": child.coins
	}
	
func save_zombie(saved_level: SaveLevel, child):
	print("saved ", child.name)
	saved_level.zombie_dict[child.name] = child.global_position
