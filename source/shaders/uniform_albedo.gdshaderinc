group_uniforms albedo;
uniform vec4 albedo_color: source_color = vec4(1.0);
uniform sampler2D albedo_texture: source_color, filter_linear_mipmap_anisotropic;
#include "function_texture_near.gdshaderinc"
vec4 albedo(vec2 coords) {
	return albedo_color * texture(albedo_texture, coords);
}
vec4 albedo(vec2 coords, float filter_size) {
	return albedo_color * textureNear(albedo_texture, coords, filter_size);
}