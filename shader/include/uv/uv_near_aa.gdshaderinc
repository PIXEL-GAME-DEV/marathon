vec2 uvNearAA(vec2 size, vec2 coords, vec2 fwidth_coords, float filter_size) {
	//vec2 texel_size = vec2(1.0) / size;
	vec2 box_size = clamp(filter_size * fwidth_coords * size, 1e-5, 1.0);
	vec2 texel = coords * size - 0.5 * box_size;
	vec2 texel_offset = smoothstep(vec2(1.0) - box_size, vec2(1.0), fract(texel));
	return (floor(texel) + 0.5 + texel_offset) / size;
}