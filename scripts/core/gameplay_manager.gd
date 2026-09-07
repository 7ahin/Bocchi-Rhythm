extends Node

@onready var music_player: AudioStreamPlayer = $"../AudioManager/MusicPlayer"
@onready var score_manager = $"../ScoreManager"

var song_end_handled: bool = false
var song_has_started: bool = false


func _ready():
	print("GameplayManager loaded!")

	music_player.finished.connect(_on_song_finished)


func _process(_delta):
	if music_player.playing:
		song_has_started = true

	# Fallback detection:
	# kalau lagu pernah start dan sekarang dah stop,
	# treat as song complete.
	if song_has_started and not music_player.playing and not song_end_handled:
		print("Song stopped playing - completing session.")
		_finish_song()


func _on_song_finished():
	print("MusicPlayer finished signal received!")

	_finish_song()


func _finish_song():
	if song_end_handled:
		return

	song_end_handled = true

	GameSession.result_score = score_manager.score
	GameSession.result_max_combo = score_manager.max_combo

	GameSession.result_perfect = score_manager.perfect_count
	GameSession.result_great = score_manager.great_count
	GameSession.result_good = score_manager.good_count
	GameSession.result_miss = score_manager.miss_count

	print("Song complete!")
	print("Final score: ", GameSession.result_score)
	print("Max combo: ", GameSession.result_max_combo)
	print(
		"Judgements: ",
		GameSession.result_perfect, " PERFECT | ",
		GameSession.result_great, " GREAT | ",
		GameSession.result_good, " GOOD | ",
		GameSession.result_miss, " MISS"
	)

	get_tree().change_scene_to_file(
		"res://scenes/results/Results.tscn"
	)