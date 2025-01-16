shader_type canvas_item;

uniform vec2 points[100];
uniform int num_points;

void fragment() {
	//vec2 uv = FRAG_COORD.xy / VIEWPORT_SIZE;
	bool is_inside = false;
	
	for (int i = 0, j = num_points - 1; i < num_points - 1; j = i++) {
		vec2 pi = points[i];
		vec2 pj = points[i + 1];
		
	if (((pi.y > UV.y) != (pj.y > UV.y)) && (UV.x < (pj.x - pi.x) * (UV.y - pi.y) / (pj.y - pi.y) + pi.x)) {
		is_inside = !is_inside;
		}
	}
	if (is_inside) {
		COLOR = vec4(0.8, 0.1, 0.2, 0.5);
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}
