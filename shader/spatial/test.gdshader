shader_type spatial;
render_mode unshaded;//, wireframe;

void fragment() {
	//NORMAL = -normalize(cross(dFdx(VERTEX), dFdy(VERTEX)));
	ALBEDO = fwidth(100000.0*TANGENT);
	//if (length(ALBEDO) < 0.01) {
		//discard;
	//}
	//ALBEDO = NORMAL;
	//ALPHA = fwidth(NORMAL);
}