shader_type canvas_item;
uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap_anisotropic, repeat_disable;
void fragment() {
	vec4 al = COLOR * texture(TEXTURE, UV);
	COLOR.rgb = texture(screen_texture, SCREEN_UV).rgb;
	COLOR.a = al.a;
}
