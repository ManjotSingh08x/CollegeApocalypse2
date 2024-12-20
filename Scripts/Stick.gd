extends StaticBody2D


var player = null

	


func _on_interactable_area_body_entered(body):
	print("something entered")
	print(body)
	if body.has_method("player"):
		print("player entered")
		player = body
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		
