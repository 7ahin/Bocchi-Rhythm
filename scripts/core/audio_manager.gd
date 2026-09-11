extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

var last_song_time: float = 0.0
var debug_timer: float = 0.0


func _ready():
	music_player.bus = "Music"

	var audio_path = GameSession.selected_audio_path

	if audio_path.is_empty():
		push_error("GameSession has no selected audio path.")
		return

	if not ResourceLoader.exists(audio_path):
		push_error("Audio file not found: " + audio_path)
		return

	music_player.stream = load(audio_path)
	music_player.play()

	print("Music started!")


func _process(delta):
	if not music_player.playing:
		return

	debug_timer += delta

	if debug_timer >= 0.5:
		debug_timer = 0.0
		print("Song time: %.3f" % get_song_time())


func get_song_time() -> float:
	if not music_player.playing:
		return last_song_time

	var song_time = music_player.get_playback_position()
	song_time += AudioServer.get_time_since_last_mix()
	song_time -= AudioServer.get_output_latency()

	# Prevent clock moving backwards due to audio-thread timing.
	song_time = max(song_time, last_song_time)
	last_song_time = song_time

	return song_time
