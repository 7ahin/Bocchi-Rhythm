extends Node

var note_scene = preload("res://scenes/gameplay/Note.tscn")

@onready var lanes = [
	$"../CenterContainer/Playfield/HBoxContainer/Lane1",
	$"../CenterContainer/Playfield/HBoxContainer/Lane2",
	$"../CenterContainer/Playfield/HBoxContainer/Lane3",
	$"../CenterContainer/Playfield/HBoxContainer/Lane4"
]

@onready var judgement_line = $"../CenterContainer/Playfield/JudgementLine"
@onready var audio_manager = $"../AudioManager"
@onready var chart_manager = $"../ChartManager"

var chart: Array = []

var travel_time: float = 1.5

var next_note_index: int = 0

func _ready():
	call_deferred("_initialize_chart")


func _initialize_chart():
	chart = chart_manager.get_notes()

	print("NoteSpawner received ", chart.size(), " notes.")

	if chart.is_empty():
		push_error("NoteSpawner received an empty chart!")
	
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
