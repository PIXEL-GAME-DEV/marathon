class_name RigidCharacterBody3D extends CharacterBody3D


enum MoveMethod {
	MOVE_AND_SLIDE,
	MOVE_AND_COLLIDE,
}

@export var move_method: MoveMethod = MoveMethod.MOVE_AND_SLIDE
@export var mass: float = 1
@export var physics_material_override: PhysicsMaterial
@export var gravity_scale: float = 1


var collision: KinematicCollision3D
var collision_angle: float
var collider: Object
var collider_id: int
var collider_rid: RID
var collider_shape: Object
var collider_shape_idx: int
var collider_velocity: Vector3
var collision_count: int
var collision_depth: float
var collision_local_shape: Object
var collision_normal: Vector3
var collision_position: Vector3
var collision_remainder: Vector3
var collision_travel: Vector3


func _physics_process(_delta: float) -> void:
	var gravity := get_gravity() * gravity_scale
	
	if gravity:
		motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED
		up_direction = -gravity.normalized()
	else:
		motion_mode = CharacterBody3D.MOTION_MODE_FLOATING
	
	apply_accel(gravity)
	
	match move_method:
		MoveMethod.MOVE_AND_SLIDE:
			move_and_slide()
			collision = get_last_slide_collision()
		#MoveMethod.MOVE_AND_COLLIDE:
			#collision = move_and_collide(velocity * delta)
	
	if collision:
		collision_angle = collision.get_angle()
		collider = collision.get_collider()
		collider_id = collision.get_collider_id()
		collider_rid = collision.get_collider_rid()
		collider_shape = collision.get_collider_shape()
		collider_shape_idx = collision.get_collider_shape_index()
		collider_velocity = collision.get_collider_velocity()
		collision_count = collision.get_collision_count()
		collision_depth = collision.get_depth()
		collision_local_shape = collision.get_local_shape()
		collision_normal = collision.get_normal()
		collision_position = collision.get_position()
		collision_remainder = collision.get_remainder()
		collision_travel = collision.get_travel()
		
		#var relative_velocity := velocity - collider_velocity
		
		
		## Friction.
		#var collider_physics_material: PhysicsMaterial
		#if collider is RigidBody3D or collider is StaticBody3D:
			#collider_physics_material = collider.physics_material_override
		#
		#var friction_self := 1.0
		#if physics_material_override:
			#friction_self = physics_material_override.friction
		#
		#var friction_other := 1.0
		#if collider_physics_material:
			#friction_other = collider_physics_material.friction
		
		#var friction_coefficient := friction_self * friction_other
		#var friction_force := -relative_velocity * 1
		#velocity -= relative_velocity
		#apply_instant_accel(friction_force)
		
		
		## Bounce.
		velocity = (collision_travel + collision_remainder).bounce(collision_normal)


func apply_force(force: Vector3) -> void:
	velocity += force * get_physics_process_delta_time() / mass


func apply_impulse(impulse: Vector3) -> void:
	velocity += impulse / mass


func apply_accel(accel: Vector3) -> void:
	velocity += accel * get_physics_process_delta_time()


func apply_instant_accel(accel: Vector3) -> void:
	velocity += accel
