extends TabBar

@onready var options_grid = $OptionsGrid

func _ready() -> void:
	options_grid.columns = 5
	
	#SignalBus.masterpiece_changed.connect(different_masterpiece)
	
func add_time_speed_sliders():
	options_grid.add_child(create_tick_speed_slider())
	options_grid.add_child(create_tock_speed_slider())
	
func create_tick_speed_slider() -> HSlider:
	var new_tik_slide = add_h_slider(0, 9)
	new_tik_slide.custom_minimum_size.x = 140
	new_tik_slide.modulate = Global.primary_color
	return new_tik_slide
	
func create_tock_speed_slider() -> HSlider:
	var new_tok_slide = add_h_slider(0, 9)
	new_tok_slide.custom_minimum_size.x = 140
	new_tok_slide.modulate = Global.secondary_color
	return new_tok_slide

func different_masterpiece(new_idutc: String):
	print(new_idutc)

func remove_gridded_options():
	for option_child in options_grid.get_children():
		option_child.queue_free()

func add_text_button(button_text: String) -> Button:
	var new_button = Button.new()
	new_button.text = button_text
	return new_button

func add_check_button(button_text: String) -> CheckButton:
	var new_button = CheckButton.new()
	#new_button.propagate_call()
	new_button.text = button_text
	return new_button
	
func add_line_edit() -> LineEdit:
	var new_line_edit = LineEdit.new()
	return new_line_edit
	
func add_label(text: String) -> Label:
	var new_label = Label.new()
	new_label.text = text
	return new_label
	
func add_h_slider(min: int, max: int) -> HSlider:
	var new_h_slider = HSlider.new()
	new_h_slider.grow_horizontal = Control.GROW_DIRECTION_BOTH
	new_h_slider.min_value = min
	new_h_slider.max_value = max
	return new_h_slider
	
func add_vbox_container(content_list: Array) -> VBoxContainer:
	var new_vbox_container = VBoxContainer.new()
	for content in content_list:
		new_vbox_container.add_child(content)
	return new_vbox_container

func reload_tab_options():
	remove_gridded_options()
	#add_time_speed_sliders()
