shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest, repeat_disable;

uniform sampler2D brush_texture;

void fragment() {
	float x = FRAGCOORD.x;
	float y = FRAGCOORD.y;
	vec4 new_color = texture(SCREEN_TEXTURE, vec2(x, y) * SCREEN_PIXEL_SIZE);
	vec4 brush_color = texture(brush_texture, vec2(x, y) * SCREEN_PIXEL_SIZE);
	COLOR = new_color * brush_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
