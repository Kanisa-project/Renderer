extends "res://UI/scripts/tab_bar_artyle.gd"

var hasSquare = false
var hasSlantDown = false
var hasSnow = false

var available_glyphs_dict = {}
var available_glyphs = []

func _ready() -> void:
	super()

func create_glyph_check(glyph_name="Round") -> CheckButton:
	var new_glyph_btn = add_check_button(glyph_name)
	new_glyph_btn.pressed.connect(activate_deactivate_glyph.bind(new_glyph_btn))
	return new_glyph_btn

func activate_deactivate_glyph(glyph_btn: CheckButton) -> void:
	if glyph_btn.button_pressed:
		available_glyphs.append(glyph_btn.text)
	else:
		for i in range(available_glyphs.count(glyph_btn.text)):
			available_glyphs.erase(glyph_btn.text)
	SignalBus.glyph_change_active.emit(available_glyphs)

func reload_tab_options():
	super()
	if "glyph" in Global.loaded_masterpiece:
		for option in Global.loaded_masterpiece["glyph"]:
			var new_glyph_check = create_glyph_check(option)
			options_grid.add_child(new_glyph_check)
			available_glyphs_dict[option] = new_glyph_check
	
