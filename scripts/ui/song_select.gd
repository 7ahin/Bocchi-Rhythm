extends Control


@onready var song_title_label: Label = $CenterContainer/VBoxContainer/SongTitleLabel
@onready var artist_label: Label = $CenterContainer/VBoxContainer/ArtistLabel

@onready var previous_button: Button = $CenterContainer/VBoxContainer/NavigationContainer/PreviousButton
@onready var next_button: Button = $CenterContainer/VBoxContainer/NavigationContainer/NextButton

@onready var select_button: Button = $CenterContainer/VBoxContainer/SelectButton
@onready var back_button: Button = $CenterContainer/VBoxContainer/BackButton


var songs: Array[Dictionary] = []
var current_song_index: int = 0


func _ready():
	previous_button.pressed.connect(_on_previous_pressed)
	next_button.pressed.connect(_on_next_pressed)
	select_button.pressed.connect(_on_select_pressed)
	back_button.pressed.connect(_on_back_pressed)

	load_song_library()


func load_song_library():
	songs = SongLibrary.get_songs()

	if songs.is_empty():
		song_title_label.text = "NO SONGS FOUND"
		artist_label.text = ""

		previous_button.disabled = true
		next_button.disabled = true
		select_button.disabled = true

		push_error("SongSelect received no songs from SongLibrary.")
		return

	current_song_index = 0

	update_song_display()


func update_song_display():
	if songs.is_empty():
		return

	var song: Dictionary = songs[current_song_index]

	song_title_label.text = song.get(
		"title",
		"Unknown Song"
	)

	artist_label.text = song.get(
		"artist",
		"Unknown Artist"
	)

	print(
		"Browsing song: ",
		song_title_label.text
	)


func _on_previous_pressed():
	if songs.is_empty():
		return

	current_song_index -= 1

	if current_song_index < 0:
		current_song_index = songs.size() - 1

	update_song_display()


func _on_next_pressed():
	if songs.is_empty():
		return

	current_song_index += 1

	if current_song_index >= songs.size():
		current_song_index = 0

	update_song_display()


func _on_select_pressed():
	if songs.is_empty():
		return

	var selected_song: Dictionary = songs[current_song_index]

	GameSession.reset_session()

	GameSession.selected_song_id = selected_song.get(
		"id",
		""
	)

	GameSession.selected_song_title = selected_song.get(
		"title",
		""
	)

	GameSession.selected_artist = selected_song.get(
		"artist",
		""
	)

	GameSession.selected_audio_path = selected_song.get(
		"audio",
		""
	)

	GameSession.selected_difficulties = selected_song.get(
		"difficulties",
		{}
	)

	print(
		"Selected song: ",
		GameSession.selected_song_title
	)

	get_tree().change_scene_to_file(
		"res://scenes/menu/DifficultySelect.tscn"
	)

func _on_back_pressed():
	get_tree().change_scene_to_file(
		"res://scenes/menu/MainMenu.tscn"
	)
