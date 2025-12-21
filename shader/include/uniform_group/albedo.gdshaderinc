group_uniforms albedo;
uniform vec4 albedo_color: source_color = vec4(1.0);
uniform sampler2D albedo_texture: source_color, filter_linear_mipmap_anisotropic;