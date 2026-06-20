class_name TerminalPage extends Resource


@export_multiline var text: String = "Lorem ipsum."
@export_group("Image", "image_")
@export var image: Texture2D = preload("res://texture/2d/compressed/marathon_logo.svg")
#@export var image_h_alignment: Control
@export var image_modulate: Color = Color.WHITE
@export var orientation: Orientation = Orientation.VERTICAL
@export var top_left_text: String = "Lorem ipsum."
@export var top_right_text: String = "Lorem ipsum."
@export var bottom_left_text: String = "PgUp/PgDn/Arrows to Scroll"
@export var bottom_right_text: String = "Return/Enter to Acknowledge"
