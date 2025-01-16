shader_type canvas_item;

uniform float x_speed: hint_range(0.0, 1.0, 0.1) = 0.6;
uniform float y_speed: hint_range(0.0, 1.0, 0.1) = 0.4;

uniform float red: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float green: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float blue: hint_range(0.0, 1.0, 0.1) = 0.5;

void vertex() {
	VERTEX.x += sin(TIME) * x_speed * 100.0;
	VERTEX.y += sin(TIME) * y_speed * 100.0;
}

void fragment() {
	vec4 icon_color = texture(TEXTURE, UV);
	vec4 mix_color = vec4(red, green/10.0, blue, green);
	COLOR = mix(icon_color, mix_color, 0.5);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
