class_name Weapon extends Resource


enum WeaponSize {
	SMALL,
	LARGE,
}

enum ShootOnInput {
	JUST_PRESSED,
	PRESSED,
	RELEASED,
}


@export_group("Apearance")
@export var model: PackedScene
@export var name: String = "Fists"
@export var name_long: String = "Fists"
@export var reticle: PackedScene

@export_group("timing", "time_")
@export var time_ready: float = 0.25
@export var time_await_reload: float = 0
@export var time_loading: float = 0
@export var time_finish_loading: float = 0
@export var time_flash_decay: float = 0

@export_group("Flags")
@export var dual_wield: bool = true
@export var fires_in_liquid: bool = true
@export var fires_in_vacuum: bool = true


@export_category("Trigger settings")
@export var trigger_main: Trigger
@export var trigger_secondary: Trigger
