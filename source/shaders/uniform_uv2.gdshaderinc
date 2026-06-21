group_uniforms uv2;
uniform vec3 uv2_scale = vec3(1.0);
uniform vec3 uv2_offset = vec3(0.0);
uniform bool uv2_triplanar = false;
uniform float uv2_triplanar_sharpness: hint_range(0.0, 150.0, 0.001) = 1.0;
uniform bool uv2_world_triplanar = false;