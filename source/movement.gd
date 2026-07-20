extends CharacterBody3D


const FIXED_ONE = 1.0
const COEFFICIENT_OF_ABSORBTION = 2

@export var monster: MonsterResource
@export var walking_physics: MovementPhysicsResource
@export var running_physics: MovementPhysicsResource
@export var collision_shape: CollisionShape3D
@export var leg_cast: ShapeCast3D
@export var leg_area: Area3D
@export var leg_collision_shape: CollisionShape3D
@export var head: Node3D
@export var yaw: Node3D
@export var pitch: Node3D
@export var camera_3d: Camera3D

var step_amplitude: float
var step_phase: float
var flags: int
var perpendicular_velocity: Vector3
var external_velocity: Vector3
var below_ground: bool
var old_below_ground: bool
var above_ground

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		turn(event.screen_relative/4000)


func _physics_process(delta: float) -> void:
	var floor_height := leg_cast.get_collision_point(0).y
	var delta_z := global_position.y - floor_height
	old_below_ground = below_ground
	#var constants := running_physics if Input.is_action_pressed("run") else walking_physics
	var constants := walking_physics if Input.is_action_pressed("run") else running_physics

	var small_enough_velocity = constants.climbing_acceleration
	var gravity := constants.gravitational_acceleration
	var terminal_velocity := constants.terminal_velocity

	var input_dir := Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward").limit_length()
	var target_vel_x := yaw.global_basis.x * (input_dir.x * constants.max_perpendicular_velocity)
	var target_vel_z := yaw.global_basis.z * (input_dir.y * (constants.max_forward_velocity if input_dir.y < 0 else constants.max_backward_velocity))

	if leg_cast.is_colliding():
		var vel := Vector2(velocity.x, velocity.z).move_toward(Vector2(target_vel_x.x + target_vel_z.x, target_vel_x.z + target_vel_z.z), 10 * delta)
		velocity.x = vel.x
		velocity.z = vel.y

	## Change vertical_velocity based on difference between player height and surface height
	## (if we are standing on an object, like a body, take that into account, too: this means a
	## player could actually use bodies as ramps to reach ledges he couldn't otherwise jump to).
	## we should think about absorbing forward (or perpendicular) velocity to compensate for an
	## increase in vertical velocity, which would slow down a player climbing stairs, etc.
	if leg_cast.is_colliding():
		velocity.y = minf(velocity.y + constants.climbing_acceleration, terminal_velocity)
	else:
		#if StaticWorld.environment_flags & ENVIRONMENT_LOW_GRAVITY:
			#gravity /= 2

		#if flags & FEET_BELOW_MEDIA_BIT:
			#gravity /= 2
			#terminal_velocity /= 2

		velocity.y = maxf(velocity.y - gravity, -terminal_velocity)

	if velocity.y > 0 and old_below_ground and not below_ground:
		velocity.y /= 2 * COEFFICIENT_OF_ABSORBTION ## slow down
	#if velocity.y > 0 and new_position.z+variables->actual_height>=variables->ceiling_height:
		#variables->external_velocity.k/= -COEFFICIENT_OF_ABSORBTION, new_position.z= variables->ceiling_height-variables->actual_height; // &&variables->position.z+variables->actual_height<variables->ceiling_height
	#}
	if velocity.y < 0 and not old_below_ground and not above_ground:
		velocity.y /= -COEFFICIENT_OF_ABSORBTION

	var CLOSE_ENOUGH_TO_FLOOR := 1.0/8
	if abs(velocity.y) < small_enough_velocity and abs(delta_z) < CLOSE_ENOUGH_TO_FLOOR:
		velocity.y = 0
		global_position.y = floor_height
		below_ground = false
		above_ground = false

	move_and_slide()


func turn(input: Vector2):
	yaw.rotation.y = wrapf(yaw.rotation.y - input.x, -PI, PI)
	pitch.rotation.x = clampf(pitch.rotation.x - input.y, -PI / 2, PI / 2)
