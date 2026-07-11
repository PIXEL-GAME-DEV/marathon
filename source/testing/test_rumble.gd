extends Control


@onready var strong_magnitude: HSlider = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/StrongMagnitude
@onready var weak_magnitude: HSlider = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer2/WeakMagnitude


func _physics_process(delta: float) -> void:
	Input.start_joy_vibration(0, weak_magnitude.value, strong_magnitude.value, delta)
