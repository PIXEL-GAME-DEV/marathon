class_name Math extends Object


static func triangle_wave(x: float, p: float) -> float:
	return 2.0*absf(x/p - floorf(x/p + 0.5))


static func random_unit_vector() -> Vector3:
	var x := randf_range(-1, 1)
	var y := randf_range(-1, 1)
	var z := randf_range(-1, 1)
	return Vector3(x, y, z).normalized()
