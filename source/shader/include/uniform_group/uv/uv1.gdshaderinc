group_uniforms uv1;
uniform vec3 uv1_scale = vec3(1.0);
uniform vec3 uv1_offset = vec3(0.0);
uniform bool uv1_triplanar = false;
uniform float uv1_triplanar_sharpness: hint_range(0.0, 150.0, 0.001) = 1.0;
uniform bool uv1_world_triplanar = false;
varying vec3 uv1_triplanar_pos;

vec3 triplanar_normal(vec3 normal, mat3 model_normal_matrix){
	return (uv1_world_triplanar) ? normal : model_normal_matrix * normal;
}

vec3 triplanar_TANGENT_BINORMAL(vec3 normal, mat3 model_normal_matrix){
	vec3 tangent_binormal;
	if (uv1_world_triplanar) {
		tangent_binormal = vec3(0.0, 0.0, -1.0) * abs(normal.x);
		tangent_binormal += vec3(1.0, 0.0, 0.0) * abs(normal.y);
		tangent_binormal += vec3(1.0, 0.0, 0.0) * abs(normal.z);
		tangent_binormal = normalize(tangent_binormal);
	}
	else {
		tangent_binormal = vec3(0.0, 0.0, -1.0) * abs(normal.x);
		tangent_binormal += vec3(1.0, 0.0, 0.0) * abs(normal.y);
		tangent_binormal += vec3(1.0, 0.0, 0.0) * abs(normal.z);
		tangent_binormal = inverse(model_normal_matrix) * normalize(tangent_binormal);
	}
	return tangent_binormal;
}

vec4 texture_triplanar(sampler2D p_sampler, vec3 p_weights, vec3 p_triplanar_pos) {
	vec4 samp = vec4(0.0);
	samp += texture(p_sampler, p_triplanar_pos.xy) * p_weights.z;
	samp += texture(p_sampler, p_triplanar_pos.xz) * p_weights.y;
	samp += texture(p_sampler, p_triplanar_pos.zy * vec2(-1.0, 1.0)) * p_weights.x;
	return samp;
}