extends ColorRect

var audio_manager: Node

var hit_time: float = 0.0
var travel_time: float = 0.0
var spawn_y: float = 0.0
var judgement_y: float = 0.0

var lane_index: int = -1
var judged: bool = false


func setup(
	audio: Node,
	target_hit_time: float,
	note_travel_time: float,
	start_y: float,
	target_y: float,
	target_lane: int
):
	audio_manager = audio
	hit_time = target_hit_time
	travel_time = note_travel_time
	spawn_y = start_y
	judgement_y = target_y
	lane_index = target_lane

	add_to_group("rhythm_notes")


func _process(_delta):
	if audio_manager == null or judged:
		return

	var song_time = audio_manager.get_song_time()
	var spawn_time = hit_time - travel_time

	var progress = (song_time - spawn_time) / travel_time
	progress = clamp(progress, 0.0, 1.2)

	position.y = lerp(spawn_y, judgement_y, progress)

	if progress >= 1.2:
		queue_free()


func register_hit():
	if judged:
		return

	judged = true

	set_process(false)

	pivot_offset = size / 2.0

	color = ThemeManager.get_accent_color()

	var tween = create_tween()

	tween.tween_property(
		self,
		"scale",
		Vector2(1.35, 1.35),
		0.07
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_callback(queue_free)

func register_miss():
	if judged:
		return

	judged = true
	set_process(false)

	pivot_offset = size / 2.0

	color = Color("#E85D6A")

	var tween = create_tween()

	tween.tween_property(
		self,
		"scale",
		Vector2(0.7, 0.7),
		0.08
	)

	tween.tween_callback(queue_free)
	judged = true
	queue_free()