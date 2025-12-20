shader_type canvas_item;
#include "res://shader/include/get_screen.gdshaderinc"
void fragment() {
	vec4 al = COLOR * texture(TEXTURE, UV);
	COLOR.rgb = getScreen(SCREEN_UV);
	COLOR.a = al.a;
}
