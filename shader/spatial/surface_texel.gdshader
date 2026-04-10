shader_type spatial;
render_mode specular_disabled;
#include "res://shader/include/uniform_group/albedo.gdshaderinc"
#include "res://shader/include/uniform_group/uv/uv1.gdshaderinc"
#include "res://shader/include/uniform_group/billboard.gdshaderinc"
#include "res://shader/include/texture/texture_near_aa.gdshaderinc"
#include "res://shader/include/spatial/fragment/texel_shadows.gdshaderinc"

void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;
	MODELVIEW_MATRIX = billboard_MODELVIEW_MATRIX(MODELVIEW_MATRIX, VIEW_MATRIX, MAIN_CAM_INV_VIEW_MATRIX, MODEL_MATRIX);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec4 albedo = albedo_color * textureNearAA(albedo_texture, UV, dFdx(UV), dFdy(UV), 1.0);
	ALBEDO = albedo.rgb;
	//ALPHA = albedo.a;
	LIGHT_VERTEX = texel_shadows(vec2(textureSize(albedo_texture, 0)), UV, dFdx(UV), dFdy(UV), VERTEX, dFdx(VERTEX), dFdy(VERTEX), 1.0);
}