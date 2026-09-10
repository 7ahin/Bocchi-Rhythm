extends Node

var hover_player: AudioStreamPlayer
var click_player: AudioStreamPlayer

var hover_sound: AudioStream
var click_sound: AudioStream


func _ready():
	hover_player = AudioStreamPlayer.new()
	click_player = AudioStreamPlayer.new()

	hover_player.bus = "SFX"
	click_player.bus = "SFX"

	add_child(hover_player)
	add_child(click_player)

	hover_player.volume_db = -12.0
	click_player.volume_db = -8.0

	load_audio()

	get_tree().node_added.connect(_on_node_added)

	call_deferred("connect_current_scene_buttons")


func load_audio():
	var hover_path := "res://assets/audio/ui/ui_hover.wav"
	var click_path := "res://assets/audio/ui/ui_click.wav"

	if ResourceLoader.exists(hover_path):
		hover_sound = load(hover_path)
		hover_player.stream = hover_sound
	else:
		print("UI hover sound not found yet.")

	if ResourceLoader.exists(click_path):
		click_sound = load(click_path)
		click_player.stream = click_sound
	else:
		print("UI click sound not found yet.")


func play_hover():
	if hover_sound == null:
		return

	hover_player.play()


func play_click():
	if click_sound == null:
		return

	click_player.play()


func connect_current_scene_buttons():
	var current_scene = get_tree().current_scene

	if current_scene == null:
		return

	connect_buttons_recursive(current_scene)


func connect_buttons_recursive(node: Node):
	if node is Button:
		connect_button(node)

	for child in node.get_children():
		connect_buttons_recursive(child)

func connect_button(button: Button):
	var hover_callable := _on_button_hover.bind(button)

	if not button.mouse_entered.is_connected(hover_callable):
		button.mouse_entered.connect(hover_callable)

	if not button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)


func _on_button_hover(button: Button):
	if button.disabled:
		return

	play_hover()


func _on_button_pressed():
	play_click()


func _on_node_added(node: Node):
	if node is Button:
		call_deferred("connect_button", node)
