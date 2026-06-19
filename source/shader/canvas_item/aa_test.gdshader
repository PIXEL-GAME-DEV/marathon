shader_type canvas_item;
uniform float p = 1.0;
void fragment() {
	COLOR = pow(COLOR, vec4(p));
}