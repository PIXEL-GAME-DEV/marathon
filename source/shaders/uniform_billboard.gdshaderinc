group_uniforms billboard;
uniform int billboard_mode: hint_enum("Disabled", "Enabled", "Y-Billboard") = 0;
uniform bool billboard_keep_scale = false;

mat4 billboard_MODELVIEW_MATRIX(mat4 MODELVIEW_MATRIX_, mat4 VIEW_MATRIX_, mat4 MAIN_CAM_INV_VIEW_MATRIX_, mat4 MODEL_MATRIX_) {
	mat4 matrix = MODELVIEW_MATRIX_; // Billboard Mode: Disabled
	switch (billboard_mode) {
		case 1: // Billboard Mode: Enabled
			matrix = VIEW_MATRIX_ * mat4(
					MAIN_CAM_INV_VIEW_MATRIX_[0],
					MAIN_CAM_INV_VIEW_MATRIX_[1],
					MAIN_CAM_INV_VIEW_MATRIX_[2],
					MODEL_MATRIX_[3]);
			break;
		case 2: // Billboard Mode: Y-Billboard
			matrix = VIEW_MATRIX_ * mat4(
					vec4(normalize(cross(vec3(0.0, 1.0, 0.0), MAIN_CAM_INV_VIEW_MATRIX_[2].xyz)), 0.0),
					vec4(0.0, 1.0, 0.0, 0.0),
					vec4(normalize(cross(MAIN_CAM_INV_VIEW_MATRIX_[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
					MODEL_MATRIX_[3]);
			break;
	}
	if (billboard_mode > 0 && billboard_keep_scale) {
		// Billboard Keep Scale: Enabled
		matrix *= mat4(
				vec4(length(MODEL_MATRIX_[0].xyz), 0.0, 0.0, 0.0),
				vec4(0.0, length(MODEL_MATRIX_[1].xyz), 0.0, 0.0),
				vec4(0.0, 0.0, length(MODEL_MATRIX_[2].xyz), 0.0),
				vec4(0.0, 0.0, 0.0, 1.0));
	}
	return matrix;
}