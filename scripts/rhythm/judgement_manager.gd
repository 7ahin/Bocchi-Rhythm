extends Node

const PERFECT_WINDOW: float = 0.050
const GREAT_WINDOW: float = 0.100
const GOOD_WINDOW: float = 0.150

@onready var audio_manager = $"../AudioManager"
@onready var score_manager = $"../ScoreManager"
@onready var judgement_label = $"../CenterContainer/Playfield/JudgementLabel"

func _ready():
	judgement_label.text = ""
	judgement_label.visible = false

func show_judgement(text: String):
	judgement_label.text = text
	judgement_label.visible = true

	await get_tree().create_timer(0.4).timeout

	judgement_label.visible = false
	judgement_label.text = ""

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
