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
			saved_level.zombie_dict[child.name] = child.global_position
		if child.has_method("chest"):
			print('save_level called')
			saved_level.chest_dict[child.name] = child.inventory.output_json()
			print(saved_level.chest_dict[child.name])

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

func check_test():
	for child in room.get_children():
		if child.has_method('chest'):
			child.inventory.test = false
	
	
	
