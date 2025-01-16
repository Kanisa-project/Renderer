shader_type canvas_item;

uniform sampler2D gradient_texture;
uniform sampler2D mask_texture;
uniform float alpha_gradient: hint_range(0.0, 1.0) = 0.5;
uniform float edge: hint_range(0.0, 1.0) = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float distance_to_center = step(edge, abs(UV.x - UV.y));
	vec4 gradient_color = texture(gradient_texture, UV);
	vec4 mask_color = texture(mask_texture, UV);
	vec4 gradient_mask = mix(gradient_color, mask_color, edge);
	COLOR.a = gradient_mask.r+.2;
}
