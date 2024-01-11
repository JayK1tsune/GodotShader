shader_type spatial;

uniform sampler2D over_texture : source_color;
uniform sampler2D under_texture : source_color;
uniform sampler2D surface_normalmap : hint_normal;

uniform vec4 top_color : source_color = vec4(0.6764, 0.980092, 1.0, 1.0);
uniform float depth = 0.1;
uniform float normal_depth = 1.0;
uniform float roughness : hint_range(0.0, 1.0) = 0.0;
uniform float metallic : hint_range(0.0, 1.0) = 0.7;
uniform float refractive_index = 0.1;

float blendOverlay_f(float base, float blend) {
	float branchless = step (base,0.5);
	return (2.0*base*blend)*branchless + (1.0-2.0*(1.0-base)*(1.0-blend))*(1.0-branchless); //This is branchless version
}

vec3 blendOverlay(vec3 base, vec3 blend) {
	return vec3(blendOverlay_f(base.r,blend.r),blendOverlay_f(base.g,blend.g),blendOverlay_f(base.b,blend.b));
}

varying vec3 ro;
varying vec3 p;
varying vec3 vertex_normal_ws;

void vertex()
{
	ro = (INV_VIEW_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xyz;// Get camera position in World space coordinates
	p = ((MODEL_MATRIX)*vec4(VERTEX,1.0)).xyz;// Get fragment position in world space coordinates
	vertex_normal_ws = ((MODEL_MATRIX)*vec4(NORMAL,1.0)).xyz;
}

void fragment(){
	vec3 normal = texture(surface_normalmap, UV).xyz * 2.0 - 1.0;
	NORMAL_MAP = texture(surface_normalmap, UV).xyz;
	NORMAL_MAP_DEPTH = normal_depth;
	
	vec3 refraction;
	vec3 rd = normalize(p - ro - normal * refractive_index) * depth;
	
	vec3 over_color = texture(over_texture, UV).rgb;
	vec3 color = blendOverlay(over_color, top_color.rgb);
	vec2 offset = rd.xz;
	vec3 under_color = texture(under_texture, UV + offset + (normal.xy)).rgb;
	ALBEDO = blendOverlay(color, under_color);
	ROUGHNESS = roughness;
	METALLIC = metallic;
}


