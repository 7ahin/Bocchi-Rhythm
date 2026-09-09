extends Node

const PERFECT_WINDOW: float = 0.050
const GREAT_WINDOW: float = 0.100
const GOOD_WINDOW: float = 0.150

@onready var audio_manager = $"../AudioManager"
@onready var score_manager = $"../ScoreManager"
@onready var judgement_label = $"../CenterContainer/Playfield/JudgementLabel"

var judgement_tween: Tween

func _ready():
	judgement_label.text = ""
	judgement_label.visible = false

func show_judgement(text: String):
	if judgement_tween != null and judgement_tween.is_valid():
		judgement_tween.kill()

	judgement_label.text = text
	judgement_label.visible = true

	match text:
		"PERFECT":
			judgement_label.modulate = Color("#F2D45C")

		"GREAT":
			judgement_label.modulate = Color("#71D5E4")

		"GOOD":
			judgement_label.modulate = Color("#F29BC2")

		"MISS":
			judgement_label.modulate = Color("#E85D6A")

		_:
			judgement_label.modulate = Color.WHITE

	judgement_label.pivot_offset = judgement_label.size / 2.0

	judgement_label.scale = Vector2(0.75, 0.75)

	judgement_tween = create_tween()

	judgement_tween.tween_property(
		judgement_label,
		"scale",
		Vector2(1.15, 1.15),
		0.08
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	judgement_tween.tween_property(
		judgement_label,
		"scale",
		Vector2.ONE,
		0.08
	)

	# Stay sekejap.
	judgement_tween.tween_interval(0.22)

	# Hide tanpa fade.
	judgement_tween.tween_callback(_hide_judgement)

func _hide_judgement():
	judgement_label.visible = false
	judgement_label.text = ""
	judgement_label.scale = Vector2.ONE

func _process(_delta):
	var song_time = audio_manager.get_song_time()

	for note in get_tree().get_nodes_in_group("rhythm_notes"):
		if note.judged:
			continue

		if song_time - note.hit_time > GOOD_WINDOW:
			print(
				"MISS",
				" | Lane ",
				note.lane_index + 1
			)

			score_manager.register_judgement("MISS")
			show_judgement("MISS")

			note.register_miss()
			
func judge_lane(lane_index: int):
	var song_time = audio_manager.get_song_time()

	var closest_note = null
	var closest_error: float = INF

	for note in get_tree().get_nodes_in_group("rhythm_notes"):
		if note.lane_index != lane_index:
			continue

		if note.judged:
			continue

		var timing_error = abs(song_time - note.hit_time)

		if timing_error < closest_error:
			closest_error = timing_error
			closest_note = note

	if closest_note == null:
		return

	if closest_error > GOOD_WINDOW:
		return

	var judgement: String

	if closest_error <= PERFECT_WINDOW:
		judgement = "PERFECT"
	elif closest_error <= GREAT_WINDOW:
		judgement = "GREAT"
	else:
		judgement = "GOOD"

	print(
		judgement,
		" | Lane ",
		lane_index + 1,
		" | Error: ",
		"%.1f ms" % (closest_error * 1000.0)
	)

	score_manager.register_judgement(judgement)
	show_judgement(judgement)
	
	closest_note.register_hit()
