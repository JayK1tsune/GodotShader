shader_type spatial;
uniform sampler2D _ablbedo: source_color;
render_mode cull_disabled;
global uniform vec4 border_color: source_color;
uniform sampler2D _noise;
uniform mat4 cutplane;
varying vec3 uvtx;

void vertex(){
	// World space cords
	uvtx = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
}

void fragment() {
	
	vec3 planeNormal = normalize(-cutplane[1].xyz);
	float planeDistance = dot(planeNormal,cutplane[3].xyz);
	float vertexDistance = dot(planeNormal, uvtx);
	float dist = vertexDistance - planeDistance;
	
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	vec2 uv = clip_pos.xy/5.0;
	uv+=TIME * 0.03;
	float noise = texture(_noise,uv).r;
	dist+= noise*0.3;
	
	if(dist < 0.0) discard;
	float border_dist = smoothstep(0.0,0.1,dist);
	vec4 alb_color = texture(_ablbedo, UV);
	ALBEDO = (mix(border_color,alb_color,border_dist)).rgb;
	EMISSION = (mix(border_color *3.0, vec4(0.0),border_dist)).rgb;
}
