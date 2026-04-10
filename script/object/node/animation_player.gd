extends AnimationPlayer
@export var anim: String = ""
func _ready() -> void:
	self.play(anim)
