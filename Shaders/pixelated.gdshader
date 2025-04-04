shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest, repeat_disable;
uniform sampler2D PALETTE_TEXTURE: hint_default_black;
uniform float pixel_size : hint_range(1.0, 16.0, 1.0) = 1.0;
uniform int palette_size: hint_range(2, 256, 1) = 8;

vec3 palette_limiter (in vec3 albedo){
	float estimation_cutoff = 0.001;
	vec3 closest_color;
	float min_dist = 2.0;
	float n = float(palette_size);

	for (int i=0; i<palette_size; i++ ){
		float index = 1.000/(2.000*n)+float(i)/n;
		vec3 index_color = texture(PALETTE_TEXTURE, vec2(index,0.5)).rgb;
		float dist = length(index_color - albedo);
		if (dist < min_dist) {
			min_dist = dist;
			closest_color = index_color;
			if (min_dist < estimation_cutoff){
				return closest_color;
			}
		}
	}
	return closest_color;
}

void fragment() {
	float x = FRAGCOORD.x - mod(FRAGCOORD.x, pixel_size);
	float y = FRAGCOORD.y - mod(FRAGCOORD.y, pixel_size);
	//centering
	float shift = floor(pixel_size / 2.0);
	vec4 new_color = texture(SCREEN_TEXTURE, vec2(x+shift, y+shift) * SCREEN_PIXEL_SIZE);
	new_color = vec4(palette_limiter(new_color.rgb), new_color.a);
	COLOR = new_color;
}