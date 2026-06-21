#include "function_uv_near.gdshaderinc"
vec3 texelShadows(vec2 texture_size, vec2 uv, vec3 vertex, float filter_size) {
	vec2 texel = uv * texture_size;
	vec2 nearest_texel = uvNear(texture_size, uv, filter_size);
	vec2 offset = nearest_texel - uv;
	offset /= dFdx(uv).x * dFdy(uv).y - dFdy(uv).x * dFdx(uv).y;

	vec2 frag_delta = vec2(
			offset.x * dFdy(uv).y - offset.y * dFdy(uv).x,
			offset.y * dFdx(uv).x - offset.x * dFdx(uv).y);

	vec3 view_delta = dFdx(vertex) * frag_delta.x + dFdy(vertex) * frag_delta.y;
	return vertex + view_delta;
}