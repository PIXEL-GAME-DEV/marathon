extends Label
var color
func _process(_delta: float) -> void:
	await RenderingServer.frame_post_draw
	var tree := get_tree()
	var root := tree.root
	var viewport_texture := root.get_texture()
	var image := viewport_texture.get_image()
	image.resize(4, 4, Image.INTERPOLATE_NEAREST)
	image.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	text = str(image.get_pixel(0, 0).get_luminance())
