@tool class_name Polyline2D extends Node2D


@export var improved := true:
	set(value):
		improved = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var points: PackedVector2Array:
	set(value):
		points = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var width := 2.0:
	set(value):
		width = value
		queue_redraw()


@export_group("Anti_aliasing", "anti_aliasing")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var anti_aliasing := true:
	set(value):
		anti_aliasing = value
		queue_redraw()

@export_range(0.01, 10, 0.001, "suffix:px") var anti_aliasing_size := 1.0:
	set(value):
		anti_aliasing_size = value
		queue_redraw()


func _draw() -> void:
	if improved:
		CanvasItemFuncs.draw_polyline(self, points, Color.WHITE, width,
				anti_aliasing, anti_aliasing_size)
	else:
		draw_polyline(points, Color.WHITE, width, anti_aliasing)
