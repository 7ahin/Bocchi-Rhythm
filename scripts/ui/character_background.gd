extends Control

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Kalau window/viewport berubah saiz,
	# background akan fit semula.
	resized.connect(_on_resized)

	call_deferred("_setup_background")


func _setup_background():
	if animated_sprite.sprite_frames == null:
		push_error("CharacterBackground has no SpriteFrames resource.")
		return

	var theme_name: String = ThemeManager.current_theme

	if animated_sprite.sprite_frames.has_animation(theme_name):
		animated_sprite.animation = theme_name

	elif animated_sprite.sprite_frames.has_animation("bocchi"):
		animated_sprite.animation = "bocchi"

	else:
		push_error("No valid character background animation found.")
		return

	animated_sprite.play()

	update_background_size()


func update_background_size():
	if animated_sprite.sprite_frames == null:
		return

	var animation_name: String = animated_sprite.animation

	if not animated_sprite.sprite_frames.has_animation(animation_name):
		return

	var texture: Texture2D = animated_sprite.sprite_frames.get_frame_texture(
		animation_name,
		0
	)

	if texture == null:
		return

	var viewport_size := get_viewport_rect().size
	var texture_size := texture.get_size()

	if texture_size.x <= 0.0 or texture_size.y <= 0.0:
		return

	animated_sprite.centered = true
	animated_sprite.position = viewport_size / 2.0


	var scale_factor: float = max(
		viewport_size.x / texture_size.x,
		viewport_size.y / texture_size.y
	)

	animated_sprite.scale = Vector2.ONE * scale_factor


func _on_resized():
	call_deferred("update_background_size")