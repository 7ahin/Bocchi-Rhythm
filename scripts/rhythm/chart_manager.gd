extends Node

var chart_data: Dictionary = {}
var notes: Array = []

var chart_path: String = ""
var is_loaded: bool = false


func _ready():
	chart_path = GameSession.selected_chart_path

	if chart_path.is_empty():
		push_error("GameSession has no selected chart path.")
		return

	print("Using chart: ", chart_path)

	load_chart()


func load_chart():
	if is_loaded:
		return

	if chart_path.is_empty():
		chart_path = GameSession.selected_chart_path

	if chart_path.is_empty():
		push_error("Chart path is empty.")
		return

	if not FileAccess.file_exists(chart_path):
		push_error("Chart file not found: " + chart_path)
		return

	var file = FileAccess.open(chart_path, FileAccess.READ)

	if file == null:
		push_error("Failed to open chart file: " + chart_path)
		return

	var json_text = file.get_as_text()
	var parsed_data = JSON.parse_string(json_text)

	if parsed_data == null:
		push_error("Failed to parse chart JSON.")
		return

	if typeof(parsed_data) != TYPE_DICTIONARY:
		push_error("Chart root must be a JSON object.")
		return

	chart_data = parsed_data
	notes = chart_data.get("notes", [])

	is_loaded = true

	print(
		"Chart loaded: ",
		chart_data.get("title", "Unknown"),
		" | Notes: ",
		notes.size()
	)


func get_notes() -> Array:
	if not is_loaded:
		load_chart()

	return notes
