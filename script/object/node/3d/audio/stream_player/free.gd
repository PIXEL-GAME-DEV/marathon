extends AudioStreamPlayer3D

enum FreeMode {
	SELF,
	PARENT,
}

@export var free_mode: FreeMode

func _ready() -> void:
	match free_mode:
		FreeMode.SELF:
			finished.connect(queue_free)
		FreeMode.PARENT:
			finished.connect(get_parent().queue_free)
