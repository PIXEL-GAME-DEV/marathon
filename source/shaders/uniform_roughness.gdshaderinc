group_uniforms roughness;
uniform float roughness: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform sampler2D roughness_texture: filter_linear_mipmap_anisotropic;
uniform int roughness_texture_channel: hint_enum("Red", "Green", "Blue", "Alpha", "Gray") = 0;