shader_type spatial;
#include "res://shader/include/random.gdshaderinc"

uniform float block_size = 2.0;
uniform float dark_block_probability: hint_range(0.0, 1.0, 0.01) = 0.8;
uniform float transfer_fade_out: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform bool bloom = false;

void fragment() {
	float time = TIME;
	//float time = 0.1;
	float moment = fract(time / 1000.0);
	float eX = 0.0;
	float eY = 0.0;
	
	if (bloom) {
		eX = moment * round((FRAGCOORD.x + mod(time, 60.0) * 7.0) / block_size);
		eY = moment * round((FRAGCOORD.y + mod(time, 60.0) * 11.0) / block_size);
	}
	else {
		eX = moment * round(FRAGCOORD.x / block_size);
		eY = moment * round(FRAGCOORD.y / block_size);
	}
	
	vec2 entropy = vec2(eX, eY);
	float sr = random(entropy);
	float sg = random(entropy * sr);
	float sb = random(entropy * sg);
	vec3 intensity = vec3(0.0);
	float dropFactor = 0.0;
	
	if (bloom) {
		if (random(entropy*sr*sg*sb) > dark_block_probability) {
			intensity = vec3(sr*sr, sg*sg, sb);
		}
		dropFactor = max(max(intensity.r, intensity.g), intensity.b);
		dropFactor = pow(dropFactor, 3.0);
	}
	else {
		intensity = vec3(sr, sg, sb);
		dropFactor = max(max(intensity.r, intensity.g), intensity.b);
		dropFactor = pow(dropFactor, 2.0);
	}
	if (dropFactor < transfer_fade_out) { discard; }
	intensity = pow(intensity, vec3(2.2));
	ALBEDO = intensity;
	//EMISSION = intensity;
	EMISSION = 10.0*intensity;
}

//void light() {}
