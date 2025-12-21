@tool
extends Range


func _init() -> void:
	changed.connect(queue_redraw)
	value_changed.connect(queue_redraw)
