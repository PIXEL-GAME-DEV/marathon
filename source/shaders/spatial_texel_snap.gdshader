shader_type spatial;
render_mode diffuse_toon;

#include "uniform_albedo.gdshaderinc"
#include "uniform_uv1.gdshaderinc"
#include "uniform_billboard.gdshaderinc"
#include "function_texel_snap.gdshaderinc"
#include "function_texture_near.gdshaderinc"

uniform sampler2D normal_map: hint_normal;
uniform float roughness: hint_range(0.0, 1.0) = 1.0;
uniform float metallic: hint_range(0.0, 1.0) = 0.0;
uniform vec2 uv_tiling = vec2(1.0);
uniform vec2 uv_offset = vec2(0.0);

void vertex() {
	UV = UV1(UV);
	MODELVIEW_MATRIX = billboard_MODELVIEW_MATRIX(
			MODELVIEW_MATRIX, VIEW_MATRIX,
			MAIN_CAM_INV_VIEW_MATRIX, MODEL_MATRIX);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	// Snap LIGHT_VERTEX and NORMAL for pixelated shadows
	vec2 delta = screenDelta(UV, vec2(textureSize(albedo_texture, 0)), 1.0);
	LIGHT_VERTEX = texelSnap(VERTEX, delta);
	NORMAL = texelSnap(NORMAL, delta);
	TANGENT = texelSnap(TANGENT, delta);
	BINORMAL = texelSnap(BINORMAL, delta);

	ALBEDO = albedo(UV, 1.0).rgb;
	NORMAL_MAP = texture(normal_map, UV).xyz;
	ROUGHNESS = roughness;
	METALLIC = metallic;
}
