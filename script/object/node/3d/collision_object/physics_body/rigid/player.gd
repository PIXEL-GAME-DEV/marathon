extends RigidBody3D


@export var turn_speed := 1.0
@export var move_speed := 5.0
#@export var air_force := 0.01
@export var jump_impulse := 1.0
@export var weapon: Weapon:
	set(value):
		weapon = value
		
		if _reticle:
			_reticle.queue_free()
		
		if weapon.reticle:
			_reticle = weapon.reticle.instantiate()
			add_child(_reticle)

@export_group("Light", "light_") 
@export var light: Light3D
@export var light_energy := 1.0

var turn_input: Vector2 = Vector2.ZERO
var last_turn_input: Vector2 = Vector2.ZERO
var move_input: Vector2 = Vector2.ZERO
var can_shoot: bool = true

#var zoom := 1.0:
	#set(value):
		#if value != zoom:
			#var tween := get_tree().create_tween()
			#tween.set_trans(Tween.TRANS_EXPO)
			#tween.set_ease(Tween.EASE_IN_OUT)
			#tween.tween_property(%Camera, "fov", 75.0/value, 0.2)
		#zoom = value

var light_on := false: set = set_light, get = is_light_on


var _physics_state: PhysicsDirectBodyState3D
var _pid := PID.new(2, 0.1, 0.03)
var _reticle: Node


func _ready() -> void:
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		turn_input -= event.screen_relative/60


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var delta := get_physics_process_delta_time()
	_physics_state = state
	var contact_velocity := Vector3.ZERO
	
	if is_on_floor(state):
		var floor_contact := get_floor_contact(state)
		contact_velocity = state.get_contact_collider_velocity_at_position(floor_contact)
	
	var relative_velocity := state.linear_velocity - contact_velocity
	
	move_input = Input.get_vector(
			"move_left", "move_right", "move_forward", "move_backward")
	var move_dir_x := global_basis.x * move_input.x
	var move_dir_z := global_basis.z * move_input.y
	var move_dir := move_dir_x + move_dir_z
	var move_target_velocity := move_dir * move_speed
	var move_velocity_error := move_target_velocity - relative_velocity
	var correction_force: Vector3 = _pid.update(move_velocity_error, delta)
	
	if is_on_floor(state):
		state.apply_central_force(correction_force * mass)
		if Input.is_action_pressed("jump"):
			state.apply_central_impulse(global_basis.y * jump_impulse * mass)
	
	%Head.rotation.y = 0
	state.transform = state.transform.rotated_local(
			Vector3.UP, turn_input.x * turn_speed * delta)
	
	turn_input.x = 0
	
	if Input.is_action_just_pressed("toggle_light"):
		toggle_light()
	
	if Input.is_action_pressed("trigger1") and weapon and can_shoot:
		can_shoot = false
		get_tree().create_timer(weapon.trigger_main.time_round, false,
				true).timeout.connect(reset_fire)
		
		var audio = AudioStreamPlayer3D.new()
		audio.finished.connect(audio.queue_free)
		%Head.add_child(audio)
		audio.stream = weapon.trigger_main.sound_firing
		audio.play()
		
		var projectile := Projectile.new(weapon.trigger_main.projectile)
		get_tree().root.add_child(projectile)
		add_collision_exception_with(projectile)
		
		var impulse_vec: Vector3 = %Head.global_basis.z
		impulse_vec = impulse_vec.rotated(Math.random_unit_vector(), randf_range(0, weapon.trigger_main.error))
		projectile.look_at(impulse_vec)
		projectile.global_position = %Head.global_position
		projectile.global_position += %Head.global_basis.x * weapon.trigger_main.offset.x
		projectile.global_position += %Head.global_basis.y * weapon.trigger_main.offset.y
		projectile.global_position += %Head.global_basis.z * weapon.trigger_main.offset.z
		#projectile.global_translate(weapon.trigger_main.offset * %Camera.global_basis)
		projectile.linear_velocity = linear_velocity
		#projectile.apply_instant_accel(velocity + impulse_vec * projectile.projectile.ballistics.speed)


func _process(delta: float) -> void:
	turn_input -= Input.get_vector("turn_left", "turn_right", "look_up", "look_down")
	
	%Head.rotation.x += turn_input.y * turn_speed * delta
	%Head.rotation.y += (turn_input.x - last_turn_input.x) * turn_speed * delta
	%Head.rotation.x = clampf(%Head.rotation.x, -PI/2, PI/2)
	
	last_turn_input = turn_input
	turn_input.y = 0


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


func reset_fire() -> void:
	can_shoot = true


#func turn()


func get_floor_contact(state: PhysicsDirectBodyState3D) -> int:
	var _state = _physics_state if _physics_state else state
	for contact in _state.get_contact_count():
		var contact_normal := _state.get_contact_local_normal(contact)
		if contact_normal.dot(-_state.total_gravity.normalized()) > 0.5:
			return contact
	return -1


func is_on_floor(state: PhysicsDirectBodyState3D) -> bool:
	var _state = _physics_state if _physics_state else state
	return get_floor_contact(_state) > -1


func get_ceiling_contact(state: PhysicsDirectBodyState3D) -> int:
	var _state = _physics_state if _physics_state else state
	for contact in _state.get_contact_count():
		var contact_normal := _state.get_contact_local_normal(contact)
		if contact_normal.dot(-_state.total_gravity.normalized()) < -0.5:
			return contact
	return -1


func is_on_ceiling(state: PhysicsDirectBodyState3D) -> bool:
	var _state = _physics_state if _physics_state else state
	return get_ceiling_contact(_state) > -1
