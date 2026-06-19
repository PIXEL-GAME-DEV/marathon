shader_type canvas_item;
#include "res://shader/include/random.gdshaderinc"
void fragment() {
	COLOR.a = random(UV + TIME) * (0.5+0.5*ceil(sin(TAU*UV.x*4.0)));
}
