extends Node

const THEME_PATH := "res://themes/bocchi_theme.tres"
const SETTINGS_PATH := "user://settings.cfg"

var game_theme: Theme
var music_volume: float = 80.0
var sfx_volume: float = 80.0
var current_theme: String = "bocchi"

var character_colors: Dictionary = {
	"bocchi": Color("#F29BC2"),
	"nijika": Color("#F2D45C"),
	"ryo": Color("#67A9D8"),
	"kita": Color("#E85D6A")
}


func _ready():
	game_theme = load(THEME_PATH)

	if game_theme == null:
		push_error("Failed to load game theme.")
		return

	load_settings()

	apply_theme(current_theme, false)
	set_bus_volume("Music", music_volume)
	set_bus_volume("SFX", sfx_volume)


func apply_theme(theme_name: String, save_preference: bool = true):
	if not character_colors.has(theme_name):
		push_error("Unknown character theme: " + theme_name)
		return

	current_theme = theme_name

	var accent: Color = character_colors[theme_name]

	update_primary_buttons(accent)
	update_accent_labels(accent)

	# Paksa UI refresh selepas theme berubah.
	game_theme.emit_changed()

	if save_preference:
		save_settings()

	print("Character theme applied: ", theme_name)


func update_primary_buttons(accent: Color):
	var normal_style = game_theme.get_stylebox(
		"normal",
		"PrimaryButton"
	)

	var hover_style = game_theme.get_stylebox(
		"hover",
		"PrimaryButton"
	)

	var pressed_style = game_theme.get_stylebox(
		"pressed",
		"PrimaryButton"
	)

	if normal_style is StyleBoxFlat:
		normal_style.bg_color = accent

	if hover_style is StyleBoxFlat:
		hover_style.bg_color = accent.lightened(0.15)

	if pressed_style is StyleBoxFlat:
		pressed_style.bg_color = accent.darkened(0.12)


func update_accent_labels(accent: Color):
	game_theme.set_color(
		"font_color",
		"AccentLabel",
		accent
	)


func get_accent_color() -> Color:
	return character_colors.get(
		current_theme,
		Color("#F29BC2")
	)

func set_bus_volume(bus_name: String, value: float):
	var bus_index := AudioServer.get_bus_index(bus_name)

	if bus_index == -1:
		return

	if value <= 0.0:
		AudioServer.set_bus_mute(bus_index, true)
		return

	AudioServer.set_bus_mute(bus_index, false)

	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value / 100.0)
	)


func set_music_volume(value: float):
	music_volume = value
	set_bus_volume("Music", value)
	save_settings()


func set_sfx_volume(value: float):
	sfx_volume = value
	set_bus_volume("SFX", value)
	save_settings()


func save_settings():
	var config := ConfigFile.new()

	config.set_value(
		"appearance",
		"character_theme",
		current_theme
	)

	config.set_value(
		"audio",
		"music_volume",
		music_volume
	)

	config.set_value(
		"audio",
		"sfx_volume",
		sfx_volume
	)

	var error := config.save(SETTINGS_PATH)

	if error != OK:
		push_error("Failed to save settings.")


func load_settings():
	var config := ConfigFile.new()

	var error := config.load(SETTINGS_PATH)

	if error != OK:
		current_theme = "bocchi"
		return

	var saved_theme: String = str(
		config.get_value(
			"appearance",
			"character_theme",
			"bocchi"
		)
	)

	if character_colors.has(saved_theme):
		current_theme = saved_theme
	else:
		current_theme = "bocchi"
	
	music_volume = float(
		config.get_value(
			"audio",
			"music_volume",
			80.0
		)
	)

	sfx_volume = float(
		config.get_value(
			"audio",
			"sfx_volume",
			80.0
		)
	)