shader_type spatial;
#include "res://shader/include/random.gdshaderinc"
void fragment() {
	float r = random(FRAGCOORD.xy + TIME);
	float g = random(FRAGCOORD.xy + TIME + 1.0);
	float b = random(FRAGCOORD.xy + TIME + 2.0);
	vec3 color = vec3(r, g, b);
	color = pow(color, vec3(3.0));
	ALBEDO = color;
	EMISSION = color;
}
