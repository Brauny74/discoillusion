shader_type canvas_item;

uniform bool dark_mode;

void fragment() {
	if(dark_mode)
		COLOR.rgb = vec3(1.0 - COLOR.r);
}