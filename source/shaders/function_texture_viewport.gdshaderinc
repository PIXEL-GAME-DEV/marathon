// A texture sampling function that lets us mip map on textures without mips
// like viewports, but it is slightly expensive.
vec4 textureViewport(sampler2D sampler, vec2 coords) {
	// Project the pixel onto the texture to find out how many texels we want to
	// sample. We're approximating the shape of the projection here as a
	// parallelogram; in perspective this projection would actually result in a
	// different shape, but this is close enough.
	vec2 uvdx = dFdx(coords);
	vec2 uvdy = dFdy(coords);
	vec2 tex_size = vec2(textureSize(sampler, 0));
	vec2 extents = vec2(length(uvdx * tex_size), length(uvdy * tex_size));

	// In each direction along the parallelogram, we want to sample at minimum
	// once and at most 32 times.
	extents = clamp(round(extents), vec2(1, 1), vec2(32, 32));
	uvdx /= extents.x;
	uvdy /= extents.y;

	// We want to start sampling from the top-left of the parallelogram, but
	// we need to offset this by half of the distance so that the sample points
	// are centered on the original UV coordinate. In other words, we want to
	// sample the fences and not the fence posts.
	coords -= (extents.x * 0.5 - 0.5) * uvdx + (extents.y * 0.5 - 0.5) * uvdy;
	vec4 result = vec4(0);
	for (float i = 0.0; i < extents.x; i++) {
		for (float j = 0.0; j < extents.y; j++) {
			vec2 uv = coords + i * uvdx + j * uvdy;
			result += texture(sampler, uv);
		}
	}
	return result / (extents.x * extents.y);
}