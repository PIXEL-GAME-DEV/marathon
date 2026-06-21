const int DITHER_SIZE = 2;
const int DITHER_MATRIX[DITHER_SIZE * DITHER_SIZE] = {
0, 2,
3, 1};
float dither(vec2 coord) {
	int wrapped_x = int(mod(coord.x, float(DITHER_SIZE)));
	int wrapped_y = int(mod(coord.y, float(DITHER_SIZE)));
	int index = wrapped_x + wrapped_y * DITHER_SIZE;
	return (float(DITHER_MATRIX[index]) + 0.5) / float(DITHER_SIZE * DITHER_SIZE);
}