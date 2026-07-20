class_name MovementPhysicsResource
extends Resource
@export_group("Movement")
@export var max_forward_velocity: float = 0.125 * 60 # 0.125 WU/tick -> 7.5 m/s
@export var max_backward_velocity: float = 0.0833 * 60 # WU/tick -> 4.998 m/s
@export var max_perpendicular_velocity: float = 0.0769 * 60 # WU/tick -> 4.614 m/s
@export var acceleration: float = 0.01 # WU/tick^2
@export var deceleration: float = 0.02 # WU/tick^2
@export var airborne_deceleration: float = 0.0056 # WU/tick^2
@export var gravitational_acceleration: float = 0.15 #0.0025 * 512 # WU/tick^2
@export var climbing_acceleration: float = 0.3 # 0.005 * 512 # WU/tick^2
@export var terminal_velocity: float = 0.1429 * 60 # 0.1429 WU/tick -> 8.574 m/s
@export var external_deceleration: float = 0.1429 * 30 # WU/tick^2
@export_group("Steps")
@export var step_delta: float = 0.05
@export var step_amplitude: float = 0.1
@export_group("Player size")
@export var radius: float = 0.5
@export var height: float = 1.6
