extends Node


@export var weapon: Weapon:
	set(value):
		weapon = value
		if _reticle:
			_reticle.queue_free()
		if weapon.reticle:
			_reticle = weapon.reticle.instantiate()
			add_child(_reticle)

var can_shoot: bool = true
var _reticle: Node


func _ready() -> void:
	pass


func _process(_delta: float):
	if Input.is_action_pressed("trigger1") and weapon and can_shoot:
		fire()


func fire():
	can_shoot = false
	get_tree().create_timer(
			weapon.trigger_main.time_round,
			false, false).timeout.connect(reset_fire)

	var audio = AudioStreamPlayer.new()
	audio.finished.connect(audio.queue_free)
	%Head.add_child(audio)
	audio.stream = weapon.trigger_main.sound_firing
	audio.play()

	var projectile := Projectile.new(weapon.trigger_main.projectile)
	get_tree().root.add_child(projectile)
	#add_collision_exception_with(projectile)

	var impulse_vec: Vector3 = %Head.global_basis.z
	impulse_vec = impulse_vec.rotated(Math.random_unit_vector(), randf_range(0, weapon.trigger_main.error))
	projectile.look_at(impulse_vec)
	projectile.global_position = %Head.global_position
	projectile.global_position += %Head.global_basis.x * weapon.trigger_main.offset.x
	projectile.global_position += %Head.global_basis.y * weapon.trigger_main.offset.y
	projectile.global_position += %Head.global_basis.z * weapon.trigger_main.offset.z
	#projectile.global_translate(weapon.trigger_main.offset * %Camera.global_basis)
	#projectile.linear_velocity = linear_velocity
	#projectile.apply_instant_accel(velocity + impulse_vec * projectile.projectile.ballistics.speed)


func reset_fire():
	can_shoot = true
