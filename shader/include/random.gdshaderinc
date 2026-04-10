float random(vec2 uv) {
	float a = 12.9898;
	float b = 78.233;
	float c = 43758.5453123;
	float dt = dot(uv.xy, vec2(a, b));
	float sn = mod(dt, 3.14);
	return fract(sin(sn) * c);
}