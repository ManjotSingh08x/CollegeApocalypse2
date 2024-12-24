extends Node
const SlotClass = preload("res://Scripts/slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")

var holding_item = null
var prev_inv = null
var coins_held: int = 69
var MAX_COINS = 9999

signal clear_holding_item
signal coin_collected


func _emit_clear_holding():
	emit_signal("clear_holding_item")
	
func _emit_coin_collected():
	emit_signal("coin_collected")
	
func add_coins(coins_given):
	print(coins_given, " coins added to inv")
	if coins_held + coins_given <= MAX_COINS:
		coins_held += coins_given
		
	else:
		coins_held = MAX_COINS
	_emit_coin_collected()
		 
