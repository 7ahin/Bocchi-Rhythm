extends CanvasLayer

var overlay: ColorRect
var transitioning: bool = false

const FADE_DURATION: float = 0.20


func _ready():
	layer = 100

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay = ColorRect.new()

	overlay.color = Color(0.09, 0.09, 0.12, 0.0)
	overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(overlay)


func change_scene(scene_path: String):
	if transitioning:
		return

	transitioning = true

	overlay.mouse_filter = Control.MOUSE_FILTER_STOP

	await fade_out()

	var error = get_tree().change_scene_to_file(scene_path)

	if error != OK:
		push_error(
			"Failed to change scene: " + scene_path
		)

		transitioning = false
		overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return

	await get_tree().process_frame

	await fade_in()

	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE

	transitioning = false


func fade_out():
	var tween = create_tween()

	tween.tween_property(
		overlay,
		"color:a",
		1.0,
		FADE_DURATION
	)

	await tween.finished


func fade_in():
	var tween = create_tween()

	tween.tween_property(
		overlay,
		"color:a",
		0.0,
		FADE_DURATION
	)

	await tween.finished