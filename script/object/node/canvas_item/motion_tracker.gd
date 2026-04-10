@tool extends CanvasItem


# @export var 


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	#if some_color < Color.BLACK:
	draw_circle(Vector2.ZERO, 64, Color(Color.WHITE, 1))
	draw_circle(Vector2(32, 0), 64, Color(Color.WHITE, 0.75))
	draw_circle(Vector2(64, 0), 64, Color(Color.WHITE, 0.5))
	draw_circle(Vector2(96, 0), 64, Color(Color.WHITE, 0.25))
