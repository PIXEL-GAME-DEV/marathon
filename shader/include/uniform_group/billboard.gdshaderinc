group_uniforms billboard;
uniform int billboard_mode: hint_enum("Disabled", "Enabled", "Y-Billboard") = 0;
uniform bool billboard_keep_scale = false;

mat4 billboard_MODELVIEW_MATRIX(mat4 modelview_matrix, mat4 view_matrix, mat4 main_cam_inv_view_matrix, mat4 model_matrix) {
	mat4 matrix = modelview_matrix; // Billboard Mode: Disabled
	switch (billboard_mode) {
		case 1: // Billboard Mode: Enabled
			matrix = view_matrix * mat4(
					main_cam_inv_view_matrix[0],
					main_cam_inv_view_matrix[1],
					main_cam_inv_view_matrix[2],
					model_matrix[3]);
			break;
		case 2: // Billboard Mode: Y-Billboard
			matrix = view_matrix * mat4(
					vec4(normalize(cross(vec3(0.0, 1.0, 0.0), main_cam_inv_view_matrix[2].xyz)), 0.0),
					vec4(0.0, 1.0, 0.0, 0.0),
					vec4(normalize(cross(main_cam_inv_view_matrix[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
					model_matrix[3]);
			break;
	}
	if (billboard_mode > 0 && billboard_keep_scale) {
		// Billboard Keep Scale: Enabled
		matrix *= mat4(
				vec4(length(model_matrix[0].xyz), 0.0, 0.0, 0.0),
				vec4(0.0, length(model_matrix[1].xyz), 0.0, 0.0),
				vec4(0.0, 0.0, length(model_matrix[2].xyz), 0.0),
				vec4(0.0, 0.0, 0.0, 1.0));
	}
	return matrix;
}