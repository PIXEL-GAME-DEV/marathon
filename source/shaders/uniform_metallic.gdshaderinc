group_uniforms metallic;
uniform float metallic: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float metallic_specular: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform sampler2D metallic_texture: filter_linear_mipmap_anisotropic;
uniform int metallic_texture_channel: hint_enum("Red", "Green", "Blue", "Alpha", "Gray") = 0;