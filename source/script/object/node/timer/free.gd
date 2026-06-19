extends Timer

enum FreeMode {
	SELF,
	PARENT,
}

@export var free_mode: FreeMode

func _ready() -> void:
	match free_mode:
		FreeMode.SELF:
			timeout.connect(queue_free)
		FreeMode.PARENT:
			timeout.connect(get_parent().queue_free)
