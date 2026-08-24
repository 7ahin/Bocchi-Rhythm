extends Control

@onready var lane_1 = $CenterContainer/HBoxContainer/Lane1
@onready var lane_2 = $CenterContainer/HBoxContainer/Lane2
@onready var lane_3 = $CenterContainer/HBoxContainer/Lane3
@onready var lane_4 = $CenterContainer/HBoxContainer/Lane4

var idle_color = Color("#303038")
var pressed_color = Color("#f2d45c")

func _ready():
	lane_1.color = idle_color
	lane_2.color = idle_color
	lane_3.color = idle_color
	lane_4.color = idle_color

func _process(_delta):
	update_lane(lane_1, Input.is_action_pressed("lane_1"))
	update_lane(lane_2, Input.is_action_pressed("lane_2"))
	update_lane(lane_3, Input.is_action_pressed("lane_3"))
	update_lane(lane_4, Input.is_action_pressed("lane_4"))

func update_lane(lane: ColorRect, pressed: bool):
	if pressed:
		lane.color = pressed_color
	else:
		lane.color = idle_color