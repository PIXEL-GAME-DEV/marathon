const int DITHER_SIZE = 8;
const int DITHER_MATRIX[DITHER_SIZE * DITHER_SIZE] = {
 0, 32,  8, 40,  2, 34, 10, 42,
48, 16, 56, 24, 50, 18, 58, 26,
12, 44,  4, 36, 14, 46,  6, 38,
60, 28, 52, 20, 62, 30, 54, 22,
 3, 35, 11, 43,  1, 33,  9, 41,
51, 19, 59, 27, 49, 17, 57, 25,
15, 47,  7, 39, 13, 45,  5, 37,
63, 31, 55, 23, 61, 29, 53, 21};
float dither(vec2 coord) {
	int wrapped_x = int(mod(coord.x, float(DITHER_SIZE)));
	int wrapped_y = int(mod(coord.y, float(DITHER_SIZE)));
	int index = wrapped_x + wrapped_y * DITHER_SIZE;
	return (float(DITHER_MATRIX[index]) + 0.5) / float(DITHER_SIZE * DITHER_SIZE);
}