class_name MonsterResource
extends Resource
@export_group("Appearance & Sounds")
@export_subgroup("Appearance")
@export_subgroup("Sounds", "sound_")
@export var sound_activation: AudioStream
@export var sound_friendly_activation: AudioStream
@export var sound_clear: AudioStream
@export var sound_kill: AudioStream
@export var sound_apology: AudioStream
@export var sound_friendly_fire: AudioStream
@export var sound_flaming: AudioStream
@export var sound_random: AudioStream
@export var sound_random_mask: int = 0
@export var sound_pitch: float = 1
@export_group("Physical constants")
@export var vitality: float = 1
@export var height: float = 1
@export var radius: float = 1
@export_subgroup("Movement")
@export var move_speed: float = 1
@export var terminal_velocity: float = 1
@export var gravity: float = 1
@export var min_ledge_jump: float = 0
@export var max_ledge_jump: float = 0
@export var external_velocity_scale: float = 1
@export var hover_height: float = 0
@export_subgroup("Perception")
@export var visual_range: float = 0
@export var dark_visual_range: float = 0
@export var intelligence: float = 0
@export_group("Behaviour settings")
@export var friends: Array[String]
@export var enemies: Array[String]
@export_group("Immunities & Weaknesses")
@export var immunities: Array[String]
@export var Weaknesses: Array[String]
