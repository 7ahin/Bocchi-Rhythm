extends Node

const SONGS_DIRECTORY := "res://data/songs/"

var songs: Array[Dictionary] = []


func _ready():
	load_songs()


func load_songs():
	songs.clear()

	var directory := DirAccess.open(SONGS_DIRECTORY)

	if directory == null:
		push_error("Failed to open songs directory: " + SONGS_DIRECTORY)
		return

	directory.list_dir_begin()

	var file_name := directory.get_next()

	while file_name != "":
		if not directory.current_is_dir() and file_name.ends_with(".json"):
			var song_path := SONGS_DIRECTORY + file_name
			var song_data := load_song_metadata(song_path)

			if not song_data.is_empty():
				songs.append(song_data)

		file_name = directory.get_next()

	directory.list_dir_end()

	print("SongLibrary loaded ", songs.size(), " songs.")

	for song in songs:
		print(
			"- ",
			song.get("title", "Unknown"),
			" | ",
			song.get("artist", "Unknown")
		)


func load_song_metadata(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		push_error("Song metadata file not found: " + path)
		return {}

	var file := FileAccess.open(path, FileAccess.READ)

	if file == null:
		push_error("Failed to open song metadata: " + path)
		return {}

	var json_text := file.get_as_text()
	var parsed_data = JSON.parse_string(json_text)

	if parsed_data == null:
		push_error("Failed to parse song metadata: " + path)
		return {}

	if typeof(parsed_data) != TYPE_DICTIONARY:
		push_error("Song metadata must be a JSON object: " + path)
		return {}

	return parsed_data


func get_songs() -> Array[Dictionary]:
	return songs


func get_song(index: int) -> Dictionary:
	if index < 0 or index >= songs.size():
		return {}

	return songs[index]