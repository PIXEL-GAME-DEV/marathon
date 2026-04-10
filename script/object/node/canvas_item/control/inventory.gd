@tool extends Tree


func _process(_delta: float) -> void:
	clear()
	set_column_title(0, "WEAPONS")
	set_column_title(1, "AMMUNITION")
	set_column_title_alignment(0, HORIZONTAL_ALIGNMENT_LEFT)
	set_column_title_alignment(1, HORIZONTAL_ALIGNMENT_LEFT)
	create_item()
	var item := create_item()
	item.set_text(0, "1 .44 MAGNUM MEGA CLASS")
	item.set_text(1, "55 .44 CLIPS (x8)")
