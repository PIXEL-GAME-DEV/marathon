#include "function_uv_near.gdshaderinc"

// Calculate screen-space displacement from the center of the current texel.
vec2 screenDelta(vec2 coords, vec2 res, float filter_size) {
	vec2 texel_center = uvNear(coords, res, filter_size);
	vec2 offset = texel_center - coords;
	mat2 screen_to_uv = mat2(dFdx(coords), dFdy(coords));
	mat2 uv_to_screen = inverse(screen_to_uv);
	return uv_to_screen * offset;
}

// Snap vec_type to extrapolated value at the center of the current texel
float texelSnap(float vec_type, vec2 delta) {
	return vec_type + dFdx(vec_type) * delta.x + dFdy(vec_type) * delta.y;
}

vec2 texelSnap(vec2 vec_type, vec2 delta) {
	return vec_type + dFdx(vec_type) * delta.x + dFdy(vec_type) * delta.y;
}

vec3 texelSnap(vec3 vec_type, vec2 delta) {
	return vec_type + dFdx(vec_type) * delta.x + dFdy(vec_type) * delta.y;
}

vec4 texelSnap(vec4 vec_type, vec2 delta) {
	return vec_type + dFdx(vec_type) * delta.x + dFdy(vec_type) * delta.y;
}