@tool class_name Arc2D extends Node2D


enum CountEditMode {
	POINTS,
	LINES,
}


@export var improved := true:
	set(value):
		improved = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var radius := 20.0:
	set(value):
		radius = clampf(value, 0, INF)
		queue_redraw()

@export_range(-360, 360, 0.01, "radians_as_degrees") var start_angle := 0.0:
	set(value):
		start_angle = value
		queue_redraw()

@export_range(-360, 360, 0.01, "radians_as_degrees") var end_angle := 360.0:
	set(value):
		end_angle = value
		queue_redraw()

@export var count := 33:
	set(value):
		match count_edit_mode:
			CountEditMode.POINTS:
				count = clampi(value, 2, 9223372036854775807)
				_point_count = clampi(value, 2, 9223372036854775807)
				_line_count = clampi(value - 1, 1,9223372036854775807)
			CountEditMode.LINES:
				count = clampi(value, 1, 9223372036854775807)
				_point_count = clampi(value + 1, 2, 9223372036854775807)
				_line_count = clampi(value, 1, 9223372036854775807)
		queue_redraw()

@export var count_edit_mode: CountEditMode:
	set(value):
		count_edit_mode = value
		match value:
			CountEditMode.POINTS:
				count = _point_count
			CountEditMode.LINES:
				count = _line_count

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var width := 2.0:
	set(value):
		width = value
		queue_redraw()


@export_group("Anti_aliasing", "anti_aliasing")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var anti_aliasing := true:
	set(value):
		anti_aliasing = value
		queue_redraw()

@export var anti_aliasing_size := 1.0:
	set(value):
		anti_aliasing_size = value
		queue_redraw()


var _point_count := 33
var _line_count := 32


func _draw() -> void:
	if improved:
		CanvasItemFuncs.draw_arc(self, Vector2.ZERO, radius, start_angle,
				end_angle, _point_count, Color.WHITE, width, anti_aliasing,
				anti_aliasing_size)
	else:
		draw_arc(Vector2.ZERO, radius, start_angle, end_angle, _point_count,
				Color.WHITE, width, anti_aliasing)
