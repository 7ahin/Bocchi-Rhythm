extends Node

@onready var pause_menu: Control = $"../HUD/PauseMenu"

@onready var resume_button: Button = $"../HUD/PauseMenu/CenterContainer/VBoxContainer/ResumeButton"
@onready var restart_button: Button = $"../HUD/PauseMenu/CenterContainer/VBoxContainer/RestartButton"
@onready var song_select_button: Button = $"../HUD/PauseMenu/CenterContainer/VBoxContainer/SongSelectButton"

@onready var music_player: AudioStreamPlayer = $"../AudioManager/MusicPlayer"


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	pause_menu.hide()

	resume_button.pressed.connect(resume_game)
	restart_button.pressed.connect(restart_game)
	song_select_button.pressed.connect(go_to_song_select)


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
		get_viewport().set_input_as_handled()


func toggle_pause():
	if get_tree().paused:
		resume_game()
	else:
		pause_game()


func pause_game():
	get_tree().paused = true
	music_player.stream_paused = true

	pause_menu.show()

	print("Game paused")


func resume_game():
	get_tree().paused = false
	music_player.stream_paused = false

	pause_menu.hide()

	print("Game resumed")


func restart_game():
	get_tree().paused = false
	music_player.stream_paused = false

	GameSession.reset_results()

	get_tree().reload_current_scene()


func go_to_song_select():
	get_tree().paused = false
	music_player.stream_paused = false

	GameSession.reset_session()

	get_tree().change_scene_to_file(
		"res://scenes/menu/SongSelect.tscn"
	)