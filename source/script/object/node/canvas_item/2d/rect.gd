@tool class_name RectPlus extends Control


@export var improved := true:
	set(value):
		improved = value
		queue_redraw()

@export var filled := true:
	set(value):
		filled = value
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
		CanvasItemFuncs.draw_rect(self, Rect2(Vector2.ZERO, get_rect().size),
				Color.WHITE, filled, width, anti_aliasing, anti_aliasing_size) 
	else:
		draw_rect(Rect2(Vector2.ZERO, get_rect().size), Color.WHITE, filled,
				width, anti_aliasing)
