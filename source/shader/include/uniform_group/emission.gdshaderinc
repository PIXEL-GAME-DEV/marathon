group_uniforms emission;
uniform bool emission_enabled = false;
uniform vec3 emission: source_color = vec3(0.0);
uniform float emission_energy_multiplier: hint_range(0.0, 16.0, 0.01) = 1.0;
uniform int emission_operator: hint_enum("Add", "Multiply") = 0;
uniform bool emission_on_uv2 = false;
uniform sampler2D emission_texture: filter_linear_mipmap_anisotropic;