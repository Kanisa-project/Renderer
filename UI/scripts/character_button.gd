extends Button

var RGB_int = [0, 0, 0]
var RGB_float = [0.0, 0.0, 0.0]
var kolor = Color(0, 0, 0)
var laer_num = 0

func _ready() -> void:
	pass

func _on_button_down() -> void:
	Global.primary_color = kolor
	Global.secondary_color = Color(RGB_float[1], RGB_float[0], RGB_float[2])
	Global.thirdary_color = Color(RGB_float[2], RGB_float[0], RGB_float[1])
	SignalBus.primary_color_changed.emit(kolor)

func _on_button_up() -> void:
	pass

func set_char_kolors(symbol: String, rgb_array: Array):
	text = symbol
	RGB_int = rgb_array
	RGB_float[0] = rgb_array[0] / 255
	RGB_float[1] = rgb_array[1] / 255
	RGB_float[2] = rgb_array[2] / 255
	kolor = Color(RGB_float[0], RGB_float[1], RGB_float[2])
	modulate = kolor
