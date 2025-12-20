@tool
class_name Arc2D
extends Node2D


@export var radius: float = 50:
	set(value):
		radius = value
		queue_redraw()

@export_range(-360, 360, 0.01, "radians_as_degrees") var start_angle: float = 0:
	set(value):
		start_angle = value
		queue_redraw()

@export_range(-360, 360, 0.01, "radians_as_degrees") var end_angle: float = 360:
	set(value):
		end_angle = value
		queue_redraw()

@export var point_count: int = 17:
	set(value):
		point_count = clampi(value, 3, 9223372036854775807)
		queue_redraw()

@export var width: float = -1:
	set(value):
		width = value
		queue_redraw()

@export var anti_aliased: bool = false:
	set(value):
		anti_aliased = value
		queue_redraw()

@export var anti_aliasing_size: float = 1:
	set(value):
		anti_aliasing_size = value
		queue_redraw()


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var aa: float = 1
	if anti_aliased:
		var scale_factor: float = 1
		var window: Window = get_window()
		if window: scale_factor = window.get_oversampling()
		# Adjust AA feather size to account for the 2D scale factor,
		# so that antialiasing doesn't become blurry at viewport resolutions
		# higher than the default when using the `canvas_items` stretch mode
		# (or when using `oversampling` values different than `1.0`).
		aa = anti_aliasing_size / scale_factor
		
	draw_set_transform(Vector2.ZERO, 0, Vector2.ONE * aa)
	draw_arc(Vector2.ZERO, radius / aa, start_angle, end_angle, point_count,
			Color.WHITE, width / aa, anti_aliased)
