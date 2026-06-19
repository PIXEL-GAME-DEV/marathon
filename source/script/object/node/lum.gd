extends SubViewport


var texture: ViewportTexture


func _init() -> void:
	texture = get_texture()


func _process(_delta: float) -> void:
	await RenderingServer.frame_post_draw
	var image := texture.get_image()
	image.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	print(image.get_pixel(0, 0))
