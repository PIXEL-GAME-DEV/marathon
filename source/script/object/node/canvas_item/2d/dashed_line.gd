@tool class_name DashedLine2D extends Node2D


@export var improved := true:
	set(value):
		improved = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var from := Vector2.ZERO:
	set(value):
		from = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var to := Vector2.ZERO:
	set(value):
		to = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var width := 2.0:
	set(value):
		width = value
		queue_redraw()

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var dash := 2.0:
	set(value):
		dash = value
		queue_redraw()

@export var aligned := false:
	set(value):
		aligned = value
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


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	if improved:
		CanvasItemFuncs.draw_dashed_line(self, from, to, Color.WHITE, width,
				dash, aligned, anti_aliasing, anti_aliasing_size)
	else:
		draw_dashed_line(from, to, Color.WHITE, width, dash, aligned,
				anti_aliasing)
