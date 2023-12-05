extends Area2D

signal player_reached(pos)

# only should detect player
func _on_area_entered(_area):
	set_deferred("monitoring", false)
	Globals.score += 50 + 5 * Globals.time_left
	Globals.frogs_reached += 1
	player_reached.emit(position)
