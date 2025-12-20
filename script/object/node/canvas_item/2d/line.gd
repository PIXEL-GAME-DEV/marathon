@tool
class_name Line2DPlus
extends Node2D


@export var from: Vector2 = Vector2.ZERO:
	set(value):
		from = value
		queue_redraw()

@export var to: Vector2 = Vector2.ZERO:
	set(value):
		to = value
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
		## Adjust AA feather size to account for the 2D scale factor,
		## so that antialiasing doesn't become blurry at viewport resolutions
		## higher than the default when using the `canvas_items` stretch mode
		## (or when using `oversampling` values different than `1.0`).
		aa = anti_aliasing_size / scale_factor
	
	draw_set_transform(Vector2.ZERO, 0, Vector2.ONE * aa)
	#draw_line(from, to, Color.WHITE, width, anti_aliased)
	draw_line(from / aa, to / aa, Color.WHITE, width / aa, anti_aliased)
