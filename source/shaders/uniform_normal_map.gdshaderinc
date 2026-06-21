group_uniforms normal_map;
uniform bool normal_map_enabled = false;
uniform float normal_scale: hint_range(-16.0, 16.0) = 1.0;
uniform sampler2D normal_texture: hint_normal, filter_linear_mipmap_anisotropic;