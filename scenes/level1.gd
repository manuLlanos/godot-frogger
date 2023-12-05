extends Level

func _on_level_won():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
