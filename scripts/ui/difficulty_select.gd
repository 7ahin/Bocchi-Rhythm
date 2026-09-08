extends Control

@onready var song_title_label = $CenterContainer/VBoxContainer/SongTitleLabel
@onready var artist_label = $CenterContainer/VBoxContainer/ArtistLabel

@onready var easy_button = $CenterContainer/VBoxContainer/DifficultyContainer/EasyButton
@onready var normal_button = $CenterContainer/VBoxContainer/DifficultyContainer/NormalButton
@onready var hard_button = $CenterContainer/VBoxContainer/DifficultyContainer/HardButton
@onready var play_button = $CenterContainer/VBoxContainer/PlayButton


func _ready():
	print("DifficultySelect loaded!")

	song_title_label.text = GameSession.selected_song_title
	artist_label.text = GameSession.selected_artist

	easy_button.pressed.connect(
		func(): select_difficulty("easy")
	)

	normal_button.pressed.connect(
		func(): select_difficulty("normal")
	)

	hard_button.pressed.connect(
		func(): select_difficulty("hard")
	)

	play_button.pressed.connect(_on_play_pressed)

	play_button.disabled = true

	update_available_difficulties()


func update_available_difficulties():
	easy_button.disabled = not GameSession.selected_difficulties.has("easy")
	normal_button.disabled = not GameSession.selected_difficulties.has("normal")
	hard_button.disabled = not GameSession.selected_difficulties.has("hard")


func select_difficulty(difficulty: String):
	if not GameSession.selected_difficulties.has(difficulty):
		return

	var difficulty_data = GameSession.selected_difficulties[difficulty]

	GameSession.selected_difficulty = difficulty
	GameSession.selected_chart_path = difficulty_data.get("chart", "")

	play_button.disabled = false

	print("Difficulty selected: ", GameSession.selected_difficulty)
	print("Chart selected: ", GameSession.selected_chart_path)


func _on_play_pressed():
	if GameSession.selected_difficulty.is_empty():
		return

	if GameSession.selected_chart_path.is_empty():
		return

	GameSession.reset_results()

	get_tree().change_scene_to_file(
		"res://scenes/gameplay/Gameplay.tscn"
	)
