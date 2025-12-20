@tool
class_name MultilineColors2D
extends Node2D


@export var points: PackedVector2Array:
	set(value):
		points = value
		queue_redraw()

@export var colors: PackedColorArray:
	set(value):
		colors = value
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
	for point in points:
		point = point / aa
	draw_multiline_colors(points, colors, width / aa, anti_aliased)
