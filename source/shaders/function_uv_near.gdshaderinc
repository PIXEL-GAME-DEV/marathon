vec2 uvNear(vec2 coords, vec2 res, float filter_size) {
	vec2 box_size = clamp(filter_size * fwidth(coords) * res, 1e-5, 1.0);
	vec2 texel = coords * res - 0.5 * box_size;
	vec2 texel_offset = smoothstep(vec2(1.0) - box_size, vec2(1.0), fract(texel));
	return (floor(texel) + 0.5 + texel_offset) / res;
}