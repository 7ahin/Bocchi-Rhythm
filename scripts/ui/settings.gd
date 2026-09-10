extends Control

@onready var bocchi_button: Button = $CenterContainer/VBoxContainer/ThemeContainer/BocchiButton
@onready var nijika_button: Button = $CenterContainer/VBoxContainer/ThemeContainer/NijikaButton
@onready var ryo_button: Button = $CenterContainer/VBoxContainer/ThemeContainer/RyoButton
@onready var kita_button: Button = $CenterContainer/VBoxContainer/ThemeContainer/KitaButton

@onready var current_theme_label: Label = $CenterContainer/VBoxContainer/CurrentThemeLabel
@onready var back_button: Button = $CenterContainer/VBoxContainer/BackButton
@onready var music_slider: HSlider = $CenterContainer/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $CenterContainer/VBoxContainer/SFXSlider

func _ready():
	bocchi_button.pressed.connect(
		func(): select_theme("bocchi")
	)

	nijika_button.pressed.connect(
		func(): select_theme("nijika")
	)

	ryo_button.pressed.connect(
		func(): select_theme("ryo")
	)

	kita_button.pressed.connect(
		func(): select_theme("kita")
	)

	back_button.pressed.connect(_on_back_pressed)

	music_slider.value_changed.connect(_on_music_volume_changed)
	sfx_slider.value_changed.connect(_on_sfx_volume_changed)

	music_slider.value = ThemeManager.music_volume
	sfx_slider.value = ThemeManager.sfx_volume

	update_theme_label()
	update_theme_buttons()


func select_theme(theme_name: String):
	ThemeManager.apply_theme(theme_name)

	update_theme_label()
	update_theme_buttons()


func update_theme_label():
	current_theme_label.text = (
		"CURRENT: "
		+ ThemeManager.current_theme.to_upper()
	)

func update_theme_buttons():
	bocchi_button.set_pressed_no_signal(
		ThemeManager.current_theme == "bocchi"
	)

	nijika_button.set_pressed_no_signal(
		ThemeManager.current_theme == "nijika"
	)

	ryo_button.set_pressed_no_signal(
		ThemeManager.current_theme == "ryo"
	)

	kita_button.set_pressed_no_signal(
		ThemeManager.current_theme == "kita"
	)

func _on_music_volume_changed(value: float):
	ThemeManager.set_music_volume(value)


func _on_sfx_volume_changed(value: float):
	ThemeManager.set_sfx_volume(value)
	
func _on_back_pressed():
	SceneTransition.change_scene(
		"res://scenes/menu/MainMenu.tscn"
	)
