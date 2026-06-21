const int DITHER_SIZE = 4;
const int DITHER_MATRIX[DITHER_SIZE * DITHER_SIZE] = {
 0,  8,  2, 10,
12,  4, 14,  6,
 3, 11,  1,  9,
15,  7, 13,  5};
float dither(vec2 coord) {
	int wrapped_x = int(mod(coord.x, float(DITHER_SIZE)));
	int wrapped_y = int(mod(coord.y, float(DITHER_SIZE)));
	int index = wrapped_x + wrapped_y * DITHER_SIZE;
	return (float(DITHER_MATRIX[index]) + 0.5) / float(DITHER_SIZE * DITHER_SIZE);
}