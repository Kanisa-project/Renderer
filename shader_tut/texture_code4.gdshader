shader_type canvas_item;

uniform float slider_progress: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float circle_size: hint_range(0.0, 1.0, 0.1) = 0.5;
const vec2 center = vec2(0.5);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float distance_to_top = step(slider_progress, UV.y);
	float distance_to_center = 1.0 - step(circle_size, distance(UV, center));
	COLOR.a = max(distance_to_center, distance_to_top);
}
