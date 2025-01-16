shader_type canvas_item;

uniform sampler2D mask_texture;
//uniform sampler2D chip_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 mask_color = texture(mask_texture, UV);
	if (mask_color == vec4(0.0, 0.0, 0.0, 1.0)) {
		//COLOR.rgb = texture_color.rgb;
		COLOR.a = 0.0;
	}
}