extends "res://UI/scripts/tab_bar_artyle.gd"

var hasRipples = false
var hasConfetti = false
var hasBoxLines = false
var hasCircleShapes = false

var available_glyths_dict = {}
var available_glyths = []

func _ready() -> void:
	super()

func create_glyth_check_button(glyth_name="Bubbles") -> CheckButton:
	var new_glyth_btn = add_check_button(glyth_name)
	new_glyth_btn.pressed.connect(activate_deactivate_glyth.bind(new_glyth_btn))
	return new_glyth_btn

func activate_deactivate_glyth(glyth_btn: CheckButton) -> void:
	if glyth_btn.button_pressed:
		available_glyths.append(glyth_btn.text)
	else:
		for i in range(available_glyths.count(glyth_btn.text)):
			available_glyths.erase(glyth_btn.text)
	SignalBus.glyth_change_active.emit(available_glyths)

func reload_tab_options():
	super()
	if "glyth" in Global.loaded_masterpiece:
		for option in Global.loaded_masterpiece["glyth"]:
			var new_glyth_check = create_glyth_check_button(option)
			options_grid.add_child(new_glyth_check)
			available_glyths_dict[option] = new_glyth_check
	
