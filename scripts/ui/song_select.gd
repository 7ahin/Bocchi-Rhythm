extends Control

@onready var select_button: Button = $CenterContainer/VBoxContainer/SelectButton

var song_metadata_path: String = "res://data/songs/test_song.json"


func _ready():
	select_button.pressed.connect(_on_select_pressed)


func _on_select_pressed():
	if not FileAccess.file_exists(song_metadata_path):
		push_error("Song metadata not found.")
		return

	var file = FileAccess.open(song_metadata_path, FileAccess.READ)
	var parsed_data = JSON.parse_string(file.get_as_text())

	if parsed_data == null:
		push_error("Failed to parse song metadata.")
		return

	GameSession.selected_song_id = parsed_data.get("id", "")
	GameSession.selected_song_title = parsed_data.get("title", "")
	GameSession.selected_artist = parsed_data.get("artist", "")
	GameSession.selected_audio_path = parsed_data.get("audio", "")
	GameSession.selected_difficulties = parsed_data.get("difficulties", {})

	GameSession.selected_difficulty = ""
	GameSession.selected_chart_path = ""

	print("Selected song: ", GameSession.selected_song_title)

	get_tree().change_scene_to_file(
		"res://scenes/menu/DifficultySelect.tscn"
	)
