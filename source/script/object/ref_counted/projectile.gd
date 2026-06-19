class_name ProjectileResource extends Resource

@export var model: PackedScene

@export_group("Physics")
@export var shape: Shape3D
@export var mass: float = 1
@export var physics_material_override: PhysicsMaterial
@export var gravity_scale: float = 1
@export var damage: Damage
@export var detonation: Detonation
@export var ballistics: Ballistics
