extends CanvasLayer

@onready var counting_label: Label = $CoinCounter/CountingLabel
@onready var Inventory = $"../Inventory"

var coins_held := 7
var MAX_COINS = 9999
# Called when the node enters the scene tree for the first time.
func _ready():
	counting_label.text = str(coins_held)
	load_coins(coins_held)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("open_inv"):
		Inventory.visible = !Inventory.visible
		Inventory.initialize_inventory()


func on_coins_recieved():
	print("coins collected")
	counting_label.text = str(coins_held)
	

#func _emit_coin_collected():
	#emit_signal("coin_collected")
	#
func add_coins(coins_given):
	print(coins_given, " coins added to inv")
	if coins_held + coins_given <= MAX_COINS:
		coins_held += coins_given
	else:
		coins_held = MAX_COINS
		
	counting_label.text = str(coins_held)
	
func load_coins(coin_data):
	coins_held = coin_data
	counting_label.text = str(coins_held)
	
	
	
