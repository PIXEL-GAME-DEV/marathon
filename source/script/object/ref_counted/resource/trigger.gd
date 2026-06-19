class_name Trigger extends Resource

@export var projectile: ProjectileResource
@export var rounds_per_magazine = 1
@export var time_round: float = 0
@export var time_recovery: float = 0
@export var time_charging: float = 0
@export var recoil_magnitude: float = 0
@export_range(0, 90, 0.01, "radians_as_degrees") var error: float = 0
@export var offset: Vector3 = Vector3.ZERO
@export var burst_count: int = 0

@export_group("Audio", "sound_")
@export var sound_firing: AudioStream
@export var sound_click: AudioStream
@export var sound_charging: AudioStream
@export var sound_shell_casing: AudioStream
@export var sound_reloading: AudioStream
@export var sound_charged: AudioStream
