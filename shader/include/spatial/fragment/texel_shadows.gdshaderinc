#include "res://shader/include/uv/uv_near_aa.gdshaderinc"
vec3 texel_shadows(vec2 texture_size, vec2 uv, vec2 dFdx_uv, vec2 dFdy_uv, vec3 vertex, vec3 dFdx_vertex, vec3 dFdy_vertex, float filter_size) {
	vec2 texel = uv * texture_size;
	vec2 fwidth_uv = abs(dFdx_uv) + abs(dFdy_uv);
	vec2 nearest_texel = uvNearAA(texture_size, uv, fwidth_uv, filter_size);
	vec2 offset = nearest_texel - uv;
	offset /= dFdx_uv.x * dFdy_uv.y - dFdy_uv.x * dFdx_uv.y;
	
	vec2 frag_delta = vec2(
			offset.x * dFdy_uv.y - offset.y * dFdy_uv.x,
			offset.y * dFdx_uv.x - offset.x * dFdx_uv.y
	);
	
	vec3 view_delta = dFdx_vertex * frag_delta.x + dFdy_vertex * frag_delta.y;
	return vertex + view_delta;
}