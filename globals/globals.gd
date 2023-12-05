extends Node

signal player_death
signal game_over
signal ui_change
signal update_timer
signal timer_ended
signal level_won

const TILE_SIZE: int = 32
const TIME_LIMIT: int = 60
const MAX_LIVES: int = 4

var score: int = 0:
	set(value):
		score = value
		ui_change.emit()

var lives: int = MAX_LIVES:
	set(value):
		if value < 0:
			game_over.emit()
			return
		lives = value
		ui_change.emit()
		player_death.emit()

var frogs_reached: int = 0:
	set(value):
		frogs_reached = value
		if value == 5:
			Globals.score += 1000 + 100 * lives
			level_won.emit()

var time_left: int = TIME_LIMIT:
	set(value):
		time_left = value
		update_timer.emit()
		if time_left == 0:
			timer_ended.emit()
