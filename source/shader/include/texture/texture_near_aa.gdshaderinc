#include "res://shader/include/uv/uv_near_aa.gdshaderinc"
vec4 textureNearAA(sampler2D sampler, vec2 coords, vec2 dFdx_coords, vec2 dFdy_coords, float filter_size) {
	vec2 texture_size = vec2(textureSize(sampler, 0));
	vec2 fwidth_coords = abs(dFdx_coords) + abs(dFdy_coords);
	vec2 uv = uvNearAA(texture_size, coords, fwidth_coords, filter_size);
	return textureGrad(sampler, uv, dFdx_coords, dFdy_coords);
}