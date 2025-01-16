shader_type canvas_item;

const vec4 color = vec4(0.8, 0.4, 0.3, 0.5);
const float alpha_multiplier = 0.5;
uniform float alpha: hint_range(0.0, 1.0) = 0.5;
uniform sampler2D gradient_texture;
uniform sampler2D noise_texture;
uniform sampler2D mask_texture;

void fragment() {
	vec4 gradient_color = texture(gradient_texture, UV);
	vec4 noise_color = texture(noise_texture, UV);
	vec4 mask_color = texture(mask_texture, UV);
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR.rbg = mix(gradient_color, noise_color, 0.2).rgb;
	COLOR.a = mix(mask_color, texture_color, 0.9).r;
}

void vertex() {
	VERTEX.x += sin(TIME) * 50.0;
	VERTEX.y += cos(TIME) * 50.0;
}