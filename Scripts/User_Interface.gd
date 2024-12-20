extends CanvasLayer

@onready var Inventory = $"../Player/Inventory"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("open_inv"):
		Inventory.visible = !Inventory.visible
		Inventory.initialize_inventory()
