extends RigidBody3D


@export var turn_speed: float = 1
@export var move_speed: float = 10
@export var move_accel: float = 25
@export var jump_force: float = 30

@export_group("Light", "light_")
@export var light: Light3D
@export var light_energy := 1.0

var turn_input: Vector2 = Vector2.ZERO
var light_on := false: set = set_light, get = is_light_on

@onready var leg_cast: ShapeCast3D = $LegCast


func _ready():
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		turn_input += event.screen_relative / 60


func _physics_process(delta: float):
	var f_delta := get_process_delta_time()
	var gravity := get_gravity()
	var surface: Object
	var s_normal := global_basis.y

	if leg_cast.is_colliding(): # Legs are standing on a surface.
		if Input.is_action_pressed("jump"):
			apply_central_force(global_basis.y * jump_force * mass)

		surface = leg_cast.get_collider(0)
		s_normal = leg_cast.get_collision_normal(0)
		#var lc_col_safe_frac := leg_cast.get_closest_collision_safe_fraction()
		#var lc_col_pos := leg_cast.to_global(lc_col_safe_frac * leg_cast.target_position)
		var s_accel: Vector3 = linear_velocity - get_safe(surface, "linear_velocity", Vector3.ZERO) - gravity

		# The surface we are standing on is accelerating
		# compared to an inertial reference frame.
		if s_accel:
			var s_accel_dir := s_accel.normalized()

			# Cancels out accelerations and gravity so we float of the ground.
			#apply_central_force(s_accel * mass)

			# Stand perpendicularly to the acceleration of the ground.
			#apply_torque(global_basis.y.cross(s_accel) * mass)
			#if not Input.is_action_pressed("jump"):
				#var d := (lc_col_pos + s_accel_dir * 0.5) - global_position
				#apply_central_force(hookes(d, linear_velocity.project(s_accel_dir), 100, 10))
		#else:
			#apply_torque(global_basis.y.cross(s_normal) * mass)
			#if not Input.is_action_pressed("jump"):
				#var d := (lc_col_pos + s_normal * 0.5) - global_position
				#apply_central_force(hookes(d, linear_velocity.project(s_normal), 100, 10))

		var move_input := Input.get_vector(
			"move_left", "move_right",
			"move_forward", "move_backward")

		#var s_velocity: Vector3 = get_safe(surface, "linear_velocity", Vector3.ZERO)
		#var relative_velocity := linear_velocity - s_velocity
		if move_input:
			var move_dir_x := global_basis.x * move_input.x
			var move_dir_z := global_basis.z * move_input.y
			var move_dir := (move_dir_x + move_dir_z).slide(s_normal)
			move_dir = move_dir.normalized() * move_input.limit_length().length()
			#var move_vel_target := move_dir * move_speed
			#var move_vel_err := (move_vel_target - relative_velocity).slide(s_normal)
			#if move_vel_err:
				#var move_error_dir := move_vel_err.normalized()
				#apply_central_force(move_error_dir * mass * move_accel)
		#else:
			#if relative_velocity:
				#apply_central_force(-relative_velocity.slide(s_normal).limit_length() * mass * move_accel)

	#angular_velocity = Vector3.ZERO
	angular_velocity = -global_basis.y * turn_input.x * turn_speed * (f_delta / delta)
	turn_input.x = 0


func _integrate_forces(_state: PhysicsDirectBodyState3D):
	pass


func _process(delta: float):
	turn_input += Input.get_vector(
		"turn_left", "turn_right",
		"look_up", "look_down")
	%Head.rotation.x -= turn_input.y * turn_speed * delta
	%Head.rotation.x = clampf(%Head.rotation.x, -PI / 2, PI / 2)
	turn_input.y = 0

	if Input.is_action_just_pressed("toggle_light"):
		toggle_light()


func set_light(value: bool):
	light_on = value
	if not light: return
	var tween := get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN_OUT)
	if light_on:
		tween.tween_property(light, "light_energy", light_energy, 0.2)
	else:
		tween.tween_property(light, "light_energy", 0, 0.2)


func is_light_on() -> bool:
	return light_on


func toggle_light() -> bool:
	light_on = not light_on
	return light_on


func hookes(displacement, velocity, stiffness, damping) -> Variant:
	return stiffness * displacement - damping * velocity


#func get_body_acceleration(body: Node3D) -> Vector3:
	#var b_vel: Vector3 = get_safe(body, "linear_velocity", Vector3.ZERO)
	#return body


func get_safe(object: Object, property: StringName, default: Variant) -> Variant:
	if not object:
		return default
	if property in object:
		return object.get(property)
	else:
		return default


#func get_body_acceleration(body: Node3D) -> Vector3:
	#if not body:
		#return Vector3.ZERO
#
	#var delta := get_physics_process_delta_time()
#
	#var b_gravity := get_gravity()
	#if body.has_method("get_gravity"):
		#b_gravity = body.get_gravity()
#
	#if body is not PhysicsBody3D:
		#return -b_gravity
#
	## Only compute using bodies that actually provide linear_velocity meaningfully.
	#var b_vel: Vector3 = get_safe(body, "linear_velocity", Vector3.ZERO)
#
	#var key := body.get_instance_id()
	#var has_prev := _prev_vel_by_body.has(key)
	#var b_vel_prev: Vector3 = _prev_vel_by_body.get(key, Vector3.ZERO)
#
	## Update stored velocity now (so next frame has it).
	#_prev_vel_by_body[key] = b_vel
#
	## If this ground body just became ground, you can't infer accel yet.
	#if not has_prev:
		#return -b_gravity
#
	#var b_accel := (b_vel - b_vel_prev) / delta
	#return b_accel - b_gravity
#
	#_ground_prev = _ground
	#_ground = body
	#_ground_vel_prev = _ground_vel
	#_ground_vel = get_safe(body, "linear_velocity", Vector3.ZERO)
	#return (_ground_vel - _ground_vel_prev) / delta - body_gravity
