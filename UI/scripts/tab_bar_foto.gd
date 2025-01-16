extends "res://UI/scripts/tab_bar_artyle.gd"

@onready var hue_slider = $FotoOptions/hsbVbox/HSldr
@onready var saturation_slider = $FotoOptions/hsbVbox/SSldr
@onready var brightness_slider = $FotoOptions/hsbVbox/BSldr
@onready var red_slider = $FotoOptions/rgbVbox/RSldr
@onready var green_slider = $FotoOptions/rgbVbox/GSldr
@onready var blue_slider = $FotoOptions/rgbVbox/USldr
@onready var alpha_blend_slider = $FotoOptions/AlphaBlendVBox/ABSldr

var tick_input_dict = {}

func _ready() -> void:
	options_grid.columns = 4
	tick_input_dict = {
		'hue': 0.0,
		'saturation': 0.0,
		'brightness': 0.0,
		'red': 0.0,
		'green': 0.0,
		'blue': 0.0
	}


func update_HSB_array(value_changed: bool, new_amount: int):
	print("HSB: ", new_amount)


func reload_tab_options():
	super()


func _on_prev_foto_btn_pressed() -> void:
	SignalBus.foto_prev.emit()


func _on_next_foto_btn_pressed() -> void:
	SignalBus.foto_next.emit()


func _on_h_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['hue'] = hue_slider.value
		$FotoOptions/hsbVbox/HLbl.text = "Hue: " + str(hue_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_s_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['saturation'] = saturation_slider.value
		$FotoOptions/hsbVbox/SLbl.text = "Saturation: " + str(saturation_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_b_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['brightness'] = brightness_slider.value
		$FotoOptions/hsbVbox/BLbl.text = "Brightness: " + str(brightness_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_r_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['red'] = red_slider.value
		$FotoOptions/rgbVbox/RLbl.text = "Red: " + str(red_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_g_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['green'] = green_slider.value
		$FotoOptions/rgbVbox/GLbl.text = "Green: " + str(green_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_u_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['blue'] = blue_slider.value
		$FotoOptions/rgbVbox/ULbl.text = "Buster: " + str(blue_slider.value)
		SignalBus.foto_change_input_dict.emit(tick_input_dict)


func _on_ab_sldr_drag_ended(value_changed: bool) -> void:
	if value_changed:
		tick_input_dict['alpha_blend'] = alpha_blend_slider.value
		SignalBus.foto_change_input_dict.emit(tick_input_dict)
