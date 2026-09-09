extends Node

@onready var score_label: Label = $"../HUD/MarginContainer/VBoxContainer/ScoreLabel"
@onready var combo_label: Label = $"../HUD/MarginContainer/VBoxContainer/ComboLabel"

@onready var song_title_label: Label = $"../HUD/MarginContainer/VBoxContainer/SongTitleLabel"
@onready var difficulty_label: Label = $"../HUD/MarginContainer/VBoxContainer/DifficultyLabel"

var combo_tween: Tween

var score: int = 0
var combo: int = 0
var max_combo: int = 0

var perfect_count: int = 0
var great_count: int = 0
var good_count: int = 0
var miss_count: int = 0


func _ready():
	song_title_label.text = GameSession.selected_song_title
	difficulty_label.text = GameSession.selected_difficulty.to_upper()

	update_ui()


func update_ui():
	score_label.text = "SCORE: %d" % score
	combo_label.text = "COMBO: %d" % combo

func animate_combo():
	if combo_tween != null and combo_tween.is_valid():
		combo_tween.kill()

	combo_label.pivot_offset = combo_label.size / 2.0
	combo_label.scale = Vector2(1.15, 1.15)

	combo_tween = create_tween()

	combo_tween.tween_property(
		combo_label,
		"scale",
		Vector2.ONE,
		0.1
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

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

	if judgement != "MISS":
		animate_combo()

	