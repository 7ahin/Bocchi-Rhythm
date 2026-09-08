extends Control

@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayButton
@onready var settings_button: Button = $CenterContainer/VBoxContainer/SettingsButton
@onready var exit_button: Button = $CenterContainer/VBoxContainer/ExitButton


func _ready():
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func _on_play_pressed():
	GameSession.reset_session()

	get_tree().change_scene_to_file(
		"res://scenes/menu/SongSelect.tscn"
	)


func _on_settings_pressed():
	print("Settings not implemented yet.")


func _on_exit_pressed():
	get_tree().quit()