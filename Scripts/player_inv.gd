extends Node
const SlotClass = preload("res://Scripts/slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")

var holding_item = null
var prev_inv = null

signal clear_holding_item

func _emit_clear_holding():
	emit_signal("clear_holding_item")
	
		 
