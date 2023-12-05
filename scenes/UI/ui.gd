extends CanvasLayer

@onready var lives_label: Label = $LivesContainer/HBoxContainer/LivesNumber
@onready var score_label: Label = $ScoreContainer/HBoxContainer/ScoreNumber

# coudln't get the textureprogress bar to work and i just want to move on from this game
@onready var timer_label: Label = $TimerContainer/HBoxContainer/TimeLeft
@onready var final_score_label: Label = $GameWonContainer/VBoxContainer/FinalScoreLabel

func _ready():
	timer_label.text = str(Globals.TIME_LIMIT)
	timer_label.modulate = Color(0, 200, 0, 1)
	$GameOverContainer.hide()
	$GameWonContainer.hide()
	$LivesContainer/HBoxContainer/LivesNumber.text = str(Globals.lives)
	Globals.connect("ui_change", update_ui)
	Globals.connect("game_over", $GameOverContainer.show)
	Globals.connect("update_timer", update_progress_bar)

func update_ui():
	lives_label.text = str(Globals.lives)
	score_label.text = str(Globals.score)

func update_progress_bar():
	timer_label.text = str(Globals.time_left)
	if Globals.time_left > 10:
		timer_label.modulate = Color(0, 200, 0, 1)
	else:
		timer_label.modulate = Color(200, 0, 0, 1)


func _on_level_game_won():
	$GameWonContainer.show()
	final_score_label.text = str(Globals.score)
