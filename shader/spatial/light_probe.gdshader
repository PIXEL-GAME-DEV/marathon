shader_type spatial;
render_mode cull_disabled;
void light() {
    DIFFUSE_LIGHT += ATTENUATION * LIGHT_COLOR / PI;
}
