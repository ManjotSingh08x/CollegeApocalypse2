extends Control


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

func _on_new_game_button_pressed() -> void:
	delete_all_user_files()


func _on_load_game_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()

func delete_all_user_files():
	print("hello")
	var dir = DirAccess.open("user://")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "." and file_name != "..":
				var file_path = "user://" + file_name
				print(file_path)
				if dir.file_exists(file_path):
					dir.remove(file_path)
			file_name = dir.get_next()

		dir.list_dir_end()
		print("All user files have been deleted.")
	else:
		print("Failed to open the user directory.")
