class_name CanvasItemFuncs extends Object


static func get_aa(canvas_item: CanvasItem, size := 1.0) -> float:
	var aa := 1.0
	var scale_factor := 1.0
	var window := canvas_item.get_window()
	if window: scale_factor = window.get_oversampling()
	# Adjust AA feather size to account for the 2D scale factor,
	# so that antialiasing doesn't become blurry at viewport resolutions
	# higher than the default when using the `canvas_items` stretch mode
	# (or when using `oversampling` values different than `1.0`).
	aa = size/scale_factor
	canvas_item.draw_set_transform(Vector2.ZERO, 0, Vector2.ONE*aa)
	return aa


static func draw_arc(canvas_item: CanvasItem, center: Vector2, radius: float,
		start_angle: float, end_angle: float, point_count: int,
		color := Color.WHITE, width := 2.0, anti_aliasing := true,
		anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		canvas_item.draw_arc(center/aa, radius/aa, start_angle, end_angle,
				point_count, color, w, true)
	else:
		canvas_item.draw_arc(center, radius, start_angle, end_angle,
				point_count, color, width, false)


static func draw_circle(canvas_item: CanvasItem, position: Vector2,
		radius: float, color := Color.WHITE, filled := true, width := 1.0,
		anti_aliasing := true, anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		if filled:
			canvas_item.draw_circle(position/aa,
					radius/aa - anti_aliasing_size*0.625, color, filled, -1,
					true)
		else:
			var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
			canvas_item.draw_circle(position/aa, radius/aa, color, filled, w,
					true)
	else:
		canvas_item.draw_circle(position, radius, color, filled, width, false)


static func draw_dashed_line(canvas_item: CanvasItem, from: Vector2,
		to: Vector2, color := Color.WHITE, width := 1.0, dash := 2.0,
		aligned := true, anti_aliasing := true, anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		canvas_item.draw_dashed_line(from/aa, to/aa, color, w, dash/aa, aligned,
				true)
	else:
		canvas_item.draw_dashed_line(from, to, color, width, dash, aligned,
				false)


static func draw_line(canvas_item: CanvasItem, from: Vector2, to: Vector2,
		color := Color.WHITE, width := 1.0, anti_aliasing := true,
		anti_aliasing_size := 1.0):
	
	var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
	#var offset := Vector2.ONE * Math.triangle_wave(width, 2)/2
	#offset *= aa
	if anti_aliasing:
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		canvas_item.draw_line(from/aa, to/aa, color, w, true)
	else:
		canvas_item.draw_line(from, to, color, width, false)


static func draw_multiline(canvas_item: CanvasItem, points: PackedVector2Array,
		color := Color.WHITE, width := 1.0, anti_aliasing := true,
		anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		var p: PackedVector2Array = []
		for point in points:
			p.append(point/aa)
		canvas_item.draw_multiline(p, color, w, true)
	else:
		canvas_item.draw_multiline(points, color, width, false)


static func draw_multiline_colors(canvas_item: CanvasItem,
		points: PackedVector2Array, colors: PackedColorArray, width := 1.0,
		anti_aliasing := true, anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		var p: PackedVector2Array = []
		for point in points:
			p.append(point/aa)
		canvas_item.draw_multiline_colors(p, colors, w, true)
	else:
		canvas_item.draw_multiline_colors(points, colors, width, false)


static func draw_polyline(canvas_item: CanvasItem, points: PackedVector2Array,
		color := Color.WHITE, width := 1.0, anti_aliasing := true,
		anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		var p: PackedVector2Array = []
		for point in points:
			p.append(point/aa)
		canvas_item.draw_polyline(p, color, w, true)
	else:
		canvas_item.draw_polyline(points, color, width, false)


static func draw_polyline_colors(canvas_item: CanvasItem,
		points: PackedVector2Array, colors: PackedColorArray, width := 1.0,
		anti_aliasing := true, anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		var w := clampf(width/aa - anti_aliasing_size*1.25, 0.0, INF)
		var p: PackedVector2Array = []
		for point in points:
			p.append(point/aa)
		canvas_item.draw_polyline_colors(p, colors, w, true)
	else:
		canvas_item.draw_polyline_colors(points, colors, width, false)


static func draw_rect(canvas_item: CanvasItem, rect: Rect2,
		color := Color.WHITE, filled := true, width := 1.0,
		anti_aliasing := true, anti_aliasing_size := 1.0):
	
	if anti_aliasing:
		var aa := CanvasItemFuncs.get_aa(canvas_item, anti_aliasing_size*0.8)
		if filled:
			canvas_item.draw_rect(
					Rect2(Vector2.ONE*anti_aliasing_size*0.625,
					rect.size/aa - Vector2.ONE*anti_aliasing_size*1.25),
					color, true, -1, true)
		else:
			var w := clampf(width/aa - 1.25, 0.0, INF)
			canvas_item.draw_rect(Rect2(Vector2.ZERO, rect.size/aa), color,
					false, w, true)
	else:
		canvas_item.draw_rect(rect, color, filled, width, false)
