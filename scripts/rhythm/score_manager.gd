extends Node

@onready var score_label = $"../HUD/MarginContainer/VBoxContainer/ScoreLabel"
@onready var combo_label = $"../HUD/MarginContainer/VBoxContainer/ComboLabel"

var score: int = 0
var combo: int = 0
var max_combo: int = 0

var perfect_count: int = 0
var great_count: int = 0
var good_count: int = 0
var miss_count: int = 0

func update_ui():
	score_label.text = "SCORE: %d" % score
	combo_label.text = "COMBO: %d" % combo

func register_judgement(judgement: String):
	match judgement:
		"PERFECT":
			score += 1000
			combo += 1
			perfect_count += 1

		"GREAT":
			score += 700
			combo += 1
			great_count += 1

		"GOOD":
			score += 400
			combo += 1
			good_count += 1

		"MISS":
			combo = 0
			miss_count += 1

	if combo > max_combo:
		max_combo = combo

	print(
		"Score: ", score,
		" | Combo: ", combo,
		" | Max Combo: ", max_combo
	)

	update_ui()