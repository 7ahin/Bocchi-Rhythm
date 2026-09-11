extends Control

@onready var perfect_label = $CenterContainer/VBoxContainer/JudgementRow/PerfectLabel
@onready var great_label = $CenterContainer/VBoxContainer/JudgementRow/GreatLabel
@onready var good_label = $CenterContainer/VBoxContainer/JudgementRow/GoodLabel
@onready var miss_label = $CenterContainer/VBoxContainer/JudgementRow/MissLabel

@onready var max_combo_label = $CenterContainer/VBoxContainer/SummaryRow/MaxComboLabel
@onready var score_label = $CenterContainer/VBoxContainer/SummaryRow/ScoreLabel
@onready var grade_label = $CenterContainer/VBoxContainer/GradeLabel

@onready var retry_button = $CenterContainer/VBoxContainer/RetryButton
@onready var song_select_button = $CenterContainer/VBoxContainer/SongSelectButton
@onready var reaction_area: Control = $CenterContainer/VBoxContainer/ReactionArea
@onready var reaction_sprite: AnimatedSprite2D = $CenterContainer/VBoxContainer/ReactionArea/ReactionSprite

func setup_reaction_position():
	if reaction_sprite.sprite_frames == null:
		return

	var animation_name: String = reaction_sprite.animation

	if not reaction_sprite.sprite_frames.has_animation(animation_name):
		return

	var texture: Texture2D = reaction_sprite.sprite_frames.get_frame_texture(
		animation_name,
		0
	)

	if texture == null:
		return

	var texture_size := texture.get_size()

	if texture_size.x <= 0.0 or texture_size.y <= 0.0:
		return

	reaction_sprite.centered = true
	reaction_sprite.position = reaction_area.size / 2.0

	var available_size := reaction_area.size - Vector2(20.0, 20.0)

	
	var scale_factor: float = min(
		available_size.x / texture_size.x,
		available_size.y / texture_size.y
	)

	reaction_sprite.scale = Vector2.ONE * scale_factor

func _ready():
	perfect_label.text = "PERFECT: %d" % GameSession.result_perfect
	great_label.text = "GREAT: %d" % GameSession.result_great
	good_label.text = "GOOD: %d" % GameSession.result_good
	miss_label.text = "MISS: %d" % GameSession.result_miss
	max_combo_label.text = "MAX COMBO: %d" % GameSession.result_max_combo
	score_label.text = "SCORE: %d" % GameSession.result_score

	var grade := calculate_grade()

	grade_label.text = "GRADE: %s" % grade

	update_result_reaction(grade)

	retry_button.pressed.connect(_on_retry_pressed)
	song_select_button.pressed.connect(_on_song_select_pressed)

	call_deferred("setup_reaction_position")


func calculate_grade() -> String:
	var total_notes = (
		GameSession.result_perfect
		+ GameSession.result_great
		+ GameSession.result_good
		+ GameSession.result_miss
	)

	if total_notes == 0:
		return "F"

	var weighted_score = (
		GameSession.result_perfect * 1.0
		+ GameSession.result_great * 0.7
		+ GameSession.result_good * 0.4
	)

	var accuracy = weighted_score / total_notes

	if accuracy >= 0.95:
		return "S"
	elif accuracy >= 0.85:
		return "A"
	elif accuracy >= 0.70:
		return "B"
	elif accuracy >= 0.55:
		return "C"
	else:
		return "D"

func update_result_reaction(grade: String):
	if grade == "S":
		show_reaction("perfect")

	elif grade == "A" or grade == "B" or grade == "C":
		show_reaction("clear")

	else:
		show_reaction("fail")

func show_reaction(animation_name: String):
	if reaction_sprite.sprite_frames == null:
		push_error("ReactionSprite has no SpriteFrames.")
		return

	if not reaction_sprite.sprite_frames.has_animation(animation_name):
		push_error(
			"Reaction animation not found: "
			+ animation_name
		)
		return

	reaction_sprite.animation = animation_name
	reaction_sprite.play()


func _on_retry_pressed():
	SceneTransition.change_scene(
		"res://scenes/gameplay/Gameplay.tscn"
	)


func _on_song_select_pressed():
	GameSession.reset_session()

	SceneTransition.change_scene(
		"res://scenes/menu/SongSelect.tscn"
	)
