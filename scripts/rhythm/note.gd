extends ColorRect

@export var fall_speed: float = 250.0

func _process(delta):
	position.y += fall_speed * delta