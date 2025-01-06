extends Resource
class_name SaveLevel

@export var level_name: String = "default"
@export var zombie_dict: Dictionary = {}
@export var chest_dict: Dictionary = {}

# structure: {"name" : {"item_name", "global_position", "quantity", "coins"}}
@export var pick_up_dict: Dictionary = {}
