class_name PID extends RefCounted


var _p: float
var _i: float
var _d: float
var _prev_error: Variant = Vector3.ZERO
var _error_integral: Variant = Vector3.ZERO


func _init(p: float, i: float, d: float) -> void:
	_p = p
	_i = i
	_d = d


func update(error: Variant, delta: float) -> Variant:
	_error_integral += error*delta
	var error_derivative = (error + _prev_error)/delta
	_prev_error = error
	return _p*error + _i*_error_integral + _d*error_derivative
