@tool
class_name Circle
extends Control


#@export var radius: float = 50:
	#set(value):
		#radius = value
		#queue_redraw()

@export var filled: bool = true:
	set(value):
		filled = value
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


func _init() -> void:
	minimum_size_changed.connect(queue_redraw)
	resized.connect(queue_redraw)
	size_flags_changed.connect(queue_redraw)


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var radius = min(size.x, size.y) / 2
	
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
	
	draw_set_transform(size / 2, 0, Vector2.ONE * aa)
	draw_circle(Vector2.ZERO, radius / aa, Color.WHITE, filled, width / aa,
			anti_aliased)
