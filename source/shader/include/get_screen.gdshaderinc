uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap_anisotropic, repeat_disable;
vec3 getScreen(vec2 screen_uv) {
	return texture(screen_texture, screen_uv).xyz;
}