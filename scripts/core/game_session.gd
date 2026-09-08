extends Node

var selected_song_id: String = ""
var selected_song_title: String = ""
var selected_artist: String = ""
var selected_audio_path: String = ""

var selected_difficulties: Dictionary = {}

var selected_chart_path: String = ""
var selected_difficulty: String = ""

var result_score: int = 0
var result_max_combo: int = 0

var result_perfect: int = 0
var result_great: int = 0
var result_good: int = 0
var result_miss: int = 0


func reset_results():
	result_score = 0
	result_max_combo = 0

	result_perfect = 0
	result_great = 0
	result_good = 0
	result_miss = 0


func reset_difficulty():
	selected_difficulty = ""
	selected_chart_path = ""

	reset_results()


func reset_session():
	selected_song_id = ""
	selected_song_title = ""
	selected_artist = ""
	selected_audio_path = ""

	selected_difficulties = {}

	selected_difficulty = ""
	selected_chart_path = ""

	reset_results()