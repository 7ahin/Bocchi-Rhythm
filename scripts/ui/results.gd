extends Control

@onready var perfect_label = $CenterContainer/VBoxContainer/PerfectLabel
@onready var great_label = $CenterContainer/VBoxContainer/GreatLabel
@onready var good_label = $CenterContainer/VBoxContainer/GoodLabel
@onready var miss_label = $CenterContainer/VBoxContainer/MissLabel

@onready var max_combo_label = $CenterContainer/VBoxContainer/MaxComboLabel
@onready var score_label = $CenterContainer/VBoxContainer/ScoreLabel
@onready var grade_label = $CenterContainer/VBoxContainer/GradeLabel

@onready var retry_button = $CenterContainer/VBoxContainer/RetryButton
@onready var song_select_button = $CenterContainer/VBoxContainer/SongSelectButton


func _ready():
	perfect_label.text = "PERFECT: %d" % GameSession.result_perfect
	great_label.text = "GREAT: %d" % GameSession.result_great
	good_label.text = "GOOD: %d" % GameSession.result_good
	miss_label.text = "MISS: %d" % GameSession.result_miss

	max_combo_label.text = "MAX COMBO: %d" % GameSession.result_max_combo
	score_label.text = "SCORE: %d" % GameSession.result_score

	grade_label.text = "GRADE: %s" % calculate_grade()

	retry_button.pressed.connect(_on_retry_pressed)
	song_select_button.pressed.connect(_on_song_select_pressed)


func calculate_grade() -> String:
	var total_notes = (
		GameSession.result_perfect
		+ GameSession.result_great
		+ GameSession.result_good
		+ GameSession.result_miss
	)

	if total_notes == 0:
		return "F"

	var weighted_score = (
		GameSession.result_perfect * 1.0
		+ GameSession.result_great * 0.7
		+ GameSession.result_good * 0.4
	)

	var accuracy = weighted_score / total_notes

	if accuracy >= 0.95:
		return "S"
	elif accuracy >= 0.85:
		return "A"
	elif accuracy >= 0.70:
		return "B"
	elif accuracy >= 0.55:
		return "C"
	else:
		return "D"


func _on_retry_pressed():
	get_tree().change_scene_to_file(
		"res://scenes/gameplay/Gameplay.tscn"
	)


func _on_song_select_pressed():
	get_tree().change_scene_to_file(
		"res://scenes/menu/SongSelect.tscn"
	)