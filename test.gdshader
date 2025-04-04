shader_type canvas_item;

uniform vec3 new_color : source_color;

void fragment() {
	COLOR.rgb = new_color;
}
