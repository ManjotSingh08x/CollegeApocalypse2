extends CanvasLayer

@onready var counting_label: Label = $CoinCounter/CountingLabel
@onready var Inventory = $"../Inventory"
# Called when the node enters the scene tree for the first time.
func _ready():
	InHand.connect("coin_collected", Callable(self, "on_coins_recieved"))
	counting_label.text = str(InHand.coins_held)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("open_inv"):
		Inventory.visible = !Inventory.visible
		Inventory.initialize_inventory()


func on_coins_recieved():
	print("coins collected")
	counting_label.text = str(InHand.coins_held)
	
