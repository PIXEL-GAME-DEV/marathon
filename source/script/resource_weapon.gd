class_name Weapon
extends Resource
@export_group("Weapon definition")
@export var item_type: String
@export var weapon_class: String
@export_subgroup("Apearance")
@export var graphic_colection: int
@export var color_table: int
@export var idle: int
@export var firing: int
@export var reloading: int
@export var charging: int
@export var charged: int
@export var flash_intensity: float = 1
#@export var model: PackedScene
#@export var name: String = "Fists"
#@export var name_long: String = "Fists"
#@export var reticle: PackedScene
@export_subgroup("timing", "time_")
@export var time_ready: float
@export var time_await_reload: float
@export var time_loading: float
@export var time_finish_loading: float
@export var time_flash_decay: float
@export_subgroup("height & Idle")
@export var idle_height: float
@export var bob_amplitude: float
@export var kick_height: float
@export var reload_height: float
@export var idle_width: float
@export_subgroup("Flags")
@export_flags("Automatic", "Disappears after use", "Plays instant shell casing sound", "Overloads", "Random ammo on pickup", "Reloads in one hand", "Fires out of phase", "Fires under liquids", "Triggers share ammo", "Angular flipping on 2nd trigger") var flags
@export_category("Trigger settings")
@export var trigger_main: WeaponTrigger
@export var trigger_secondary: WeaponTrigger
