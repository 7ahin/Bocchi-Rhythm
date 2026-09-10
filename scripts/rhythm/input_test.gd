extends Control

@onready var lane_1 = $CenterContainer/Playfield/HBoxContainer/Lane1
@onready var lane_2 = $CenterContainer/Playfield/HBoxContainer/Lane2
@onready var lane_3 = $CenterContainer/Playfield/HBoxContainer/Lane3
@onready var lane_4 = $CenterContainer/Playfield/HBoxContainer/Lane4

@onready var hbox = $CenterContainer/Playfield/HBoxContainer
@onready var judgement_line = $CenterContainer/Playfield/JudgementLine

@onready var judgement_manager = $JudgementManager


var lane_normal_color := Color("#24242F")
var lane_pressed_color: Color


func _ready():
	# Ambil warna character theme semasa.
	lane_pressed_color = ThemeManager.get_accent_color()

	# Judgement line ikut character theme.
	judgement_line.color = lane_pressed_color

	call_deferred("sync_judgement_line")


func sync_judgement_line():
	judgement_line.position.x = hbox.position.x
	judgement_line.size.x = hbox.size.x


func _process(_delta):
	if Input.is_action_just_pressed("lane_1"):
		judgement_manager.judge_lane(0)

	if Input.is_action_just_pressed("lane_2"):
		judgement_manager.judge_lane(1)

	if Input.is_action_just_pressed("lane_3"):
		judgement_manager.judge_lane(2)

	if Input.is_action_just_pressed("lane_4"):
		judgement_manager.judge_lane(3)

	update_lane(
		lane_1,
		Input.is_action_pressed("lane_1")
	)

	update_lane(
		lane_2,
		Input.is_action_pressed("lane_2")
	)

	update_lane(
		lane_3,
		Input.is_action_pressed("lane_3")
	)

	update_lane(
		lane_4,
		Input.is_action_pressed("lane_4")
	)


func update_lane(lane: ColorRect, pressed: bool):
	if pressed:
		lane.color = lane_pressed_color
	else:
		lane.color = lane_normal_color
