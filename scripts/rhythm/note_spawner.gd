extends Node

var note_scene = preload("res://scenes/gameplay/Note.tscn")

@onready var lanes = [
	$"../CenterContainer/HBoxContainer/Lane1",
	$"../CenterContainer/HBoxContainer/Lane2",
	$"../CenterContainer/HBoxContainer/Lane3",
	$"../CenterContainer/HBoxContainer/Lane4"
]

@onready var judgement_line = $"../JudgementLine"
@onready var audio_manager = $"../AudioManager"

var travel_time: float = 1.5

var chart = [
	{"time": 3.0, "lane": 0},
	{"time": 4.0, "lane": 1},
	{"time": 5.0, "lane": 2},
	{"time": 6.0, "lane": 3},
	{"time": 7.0, "lane": 0},
	{"time": 8.0, "lane": 2},
	{"time": 9.0, "lane": 1},
	{"time": 10.0, "lane": 3}
]

var next_note_index: int = 0


func _process(_delta):
	var song_time = audio_manager.get_song_time()

	while next_note_index < chart.size():
		var note_data = chart[next_note_index]

		var spawn_time = note_data["time"] - travel_time

		if song_time >= spawn_time:
			spawn_note(
				note_data["lane"],
				note_data["time"]
			)

			next_note_index += 1
		else:
			break


func spawn_note(lane_index: int, hit_time: float):
	var lane = lanes[lane_index]
	var note = note_scene.instantiate()

	lane.add_child(note)

	var note_x = (lane.size.x - note.size.x) / 2.0

	var spawn_y = 0.0

	var judgement_y = (
		judgement_line.global_position.y
		- lane.global_position.y
		- note.size.y / 2.0
	)

	note.position.x = note_x

	note.setup(
		audio_manager,
		hit_time,
		travel_time,
		spawn_y,
		judgement_y,
		lane_index
	)
