class_name Projectile extends RigidBody3D


@export var projectile: ProjectileResource

var _col_shape: CollisionShape3D
var _model: Node
var _physics_state: PhysicsDirectBodyState3D


func _init(projectile_resource: ProjectileResource) -> void:
	continuous_cd = true
	contact_monitor = true
	max_contacts_reported = 1
	
	projectile = projectile_resource
	gravity_scale = projectile.gravity_scale
	
	_col_shape = CollisionShape3D.new()
	add_child(_col_shape)
	_col_shape.shape = projectile.shape
	
	if projectile.model:
		_model = projectile.model.instantiate()
		add_child(_model)
	
	body_entered.connect(hit)


func _ready() -> void:
	await get_tree().physics_frame
	if projectile.ballistics:
		linear_velocity += global_basis.z * projectile.ballistics.speed
		if projectile.ballistics.max_range > 0:
			var time := projectile.ballistics.max_range / projectile.ballistics.speed
			get_tree().create_timer(time, false, true).timeout.connect(delete)


func _physics_process(_delta: float) -> void:
	look_at(global_position + linear_velocity)


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	_physics_state = state


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


func hit(body: Node) -> void:
	var gravity := get_gravity()
	var gravity_direction := gravity.normalized()
	var up := -gravity_direction
	var contact_position := _physics_state.get_contact_local_position(0)
	var contact_normal := _physics_state.get_contact_local_normal(0)
	
	if projectile.detonation.effect:
		var effect: Node3D = projectile.detonation.effect.instantiate()
		body.add_child(effect)
		effect.global_position = contact_position
		effect.look_at(effect.global_position + contact_normal, up)
		effect.rotate_object_local(Vector3.FORWARD, randf_range(0, TAU))
	
	queue_free()
	
	#var relative_velocity: Vector3 = linear_velocity - body.linear_velocity
	#var force := pow(relative_velocity.length() / projectile.speed, 2)
	#var damage_base := randf_range(0, projectile.damage.random) + projectile.damage.amount
	#var damage_scaled := damage_base * force


func delete() -> void:
	await get_tree().physics_frame
	queue_free()
