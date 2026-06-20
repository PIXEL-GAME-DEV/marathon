@tool class_name ConeShape3D extends ConvexPolygonShape3D


## The height of the cone.
@export_range(0, 100, 0.001, "or_greater", "suffix:m") var height := 2.0:
	set(value):
		height = value
		_request_resize()

## The size of the bottom of the cone.
@export_custom(PROPERTY_HINT_NONE, "suffix:m") var size := Vector2.ONE:
	set(value):
		size = value.clampf(0, INF)
		_request_resize()

## The number of radial segments of the cone
@export var resolution: int = 8:
	set(value):
		resolution = value
		_request_resize()


# Resize requested
var pending_resize := false


# Update size to initial state
func _init() -> void:
	_request_resize()


# Will only resize once per frame, during idle time
func _request_resize() -> void:
	if !pending_resize:
		_update_size.call_deferred()
		pending_resize = true


# Updates shape size
func _update_size() -> void:
	points = _make_cone_polygon_points()
	pending_resize = false


# Makes a cone polygon
@warning_ignore("return_value_discarded")
func _make_cone_polygon_points() -> PackedVector3Array:
	var pts: PackedVector3Array = []
	var top: Vector3 = Vector3(0, height/2, 0)
	for i in resolution:
		var angle := float(i) * TAU / resolution
		var x := cos(angle) * size.x / 2
		var y := sin(angle) * size.y / 2
		pts.push_back(Vector3(x, -height/2, y))
	pts.push_back(top)
	return pts
