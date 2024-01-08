shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D dissolve_tex : hint_default_white;
uniform vec4 front_colour : source_color;
uniform vec4 back_colour : source_color;
uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float a = COLOR.r - texture(dissolve_tex, UV).x;
	ALPHA = step(0.0,a);
	ALPHA_SCISSOR_THRESHOLD = 0.1;
	ALBEDO = front_colour.rgb;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
