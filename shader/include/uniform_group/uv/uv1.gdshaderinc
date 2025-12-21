group_uniforms uv1;
uniform vec3 uv1_scale = vec3(1.0);
uniform vec3 uv1_offset = vec3(0.0);
uniform bool uv1_triplanar = false;
uniform float uv1_triplanar_sharpness: hint_range(0.0, 150.0, 0.001) = 1.0;
uniform bool uv1_world_triplanar = false;