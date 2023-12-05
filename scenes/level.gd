extends Node2D
class_name Level

signal game_won

var victory_frog_scene: PackedScene = preload("res://scenes/victory_frog.tscn")
var player_frog_scene: PackedScene = preload("res://scenes/frog.tscn")

@onready var lilypads: Array = $LilyPads.get_children()
@onready var player = $Frog
@onready var player_start_position = player.position

var is_game_over: bool = false

func _ready():
	Globals.connect("player_death", respawn_player)
	Globals.connect("game_over", _on_game_over)
	Globals.connect("timer_ended", _on_timer_ended)
	Globals.connect("level_won", _on_level_won)
	for lilypad in lilypads:
		lilypad.connect("player_reached", _on_player_score)

func _on_player_score(pos):
	Globals.time_left = Globals.TIME_LIMIT
	reset_player_position()
	var victory_frog = victory_frog_scene.instantiate()
	victory_frog.position = pos
	call_deferred("add_child", victory_frog)


func reset_player_position():
	player.teleport_to(player_start_position)

func respawn_player():
	await get_tree().create_timer(1).timeout
	player = player_frog_scene.instantiate()
	player.position = player_start_position
	player.z_index = 1
	call_deferred("add_child", player)
	Globals.time_left = Globals.TIME_LIMIT
	$Timer.start()


func _on_game_over():
	is_game_over = true
	$Timer.stop()


func _unhandled_input(event):
	if is_game_over and event.is_action_pressed("restart"):
		restart_game()

func restart_game():
	Globals.lives = Globals.MAX_LIVES
	Globals.score = 0
	Globals.time_left = Globals.TIME_LIMIT
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func _on_timer_ended():
	player.splat()
	$Timer.stop()

func _on_timer_timeout():
	Globals.time_left -= 1


# im only doing one level im bored of this lol
func _on_level_won():
	#level specific stuff here if i made more levels
	
	# this would be for the last level
	is_game_over = true
	$Timer.stop()
	player.queue_free()
	game_won.emit()
