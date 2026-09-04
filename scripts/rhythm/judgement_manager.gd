extends Node

const PERFECT_WINDOW: float = 0.050
const GREAT_WINDOW: float = 0.100
const GOOD_WINDOW: float = 0.150

@onready var audio_manager = $"../AudioManager"


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

	closest_note.register_hit()