#include "function_uv_near.gdshaderinc"
vec4 textureNear(sampler2D sampler, vec2 coords, float filter_size) {
	vec2 texture_size = vec2(textureSize(sampler, 0));
	vec2 uv = uvNear(coords, texture_size, filter_size);
	return textureGrad(sampler, uv, dFdx(coords), dFdy(coords));
}