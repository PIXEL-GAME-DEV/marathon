shader_type spatial;

uniform sampler2D image: filter_linear_mipmap_anisotropic;
//uniform vec2 tiling = vec2(1.0);
//uniform vec2 offset = vec2(0.0);

varying vec4 node_position_clip;
varying float n;


void vertex() {
	 node_position_clip = (PROJECTION_MATRIX * vec4(NODE_POSITION_VIEW, 1.0));
}

void fragment() {
	vec2 local_uv = (SCREEN_UV * 2.0 - 1.0) * node_position_clip.w - node_position_clip.xy;
	
	// Adjust for aspect ratio and FOV
	//local_uv.x *= VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
	//local_uv *= -1.0 / PROJECTION_MATRIX[1][1];
	
	local_uv /= node_position_clip.w;
	vec2 tiling = VIEWPORT_SIZE / vec2(textureSize(image, 0)) / 3.0;
	
	
	// original
	//ALBEDO = texture(image, local_uv * tiling + 0.5 + offset).rgb;
	
	
	//ALBEDO = texture(image, local_uv * tiling).rgb;
	n = texture(image, local_uv * tiling).r;
}

void light() {
	float l = clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION;
	//float d = n
	float d = 0.0;
	if (l > n) {
		d = 1.0;
	}
	else {
		d = 0.0;
	}
	DIFFUSE_LIGHT += d * LIGHT_COLOR / PI;
}
