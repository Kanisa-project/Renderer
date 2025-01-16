extends HBoxContainer

@onready var color_rect_grid = $ColorPaletteGrid
@onready var artribute_grid = $ArtributeGrid

@onready var layer_texture = $ColorPaletteGrid

@onready var accuracy_btn = $ArtributeGrid/AccuracyBtn
@onready var transparency_btn = $ArtributeGrid/TransparencyBtn
@onready var size_btn = $ArtributeGrid/SizeBtn
@onready var anim_speed_btn = $ArtributeGrid/AnimSpeedBtn
@onready var anim_amount_btn = $ArtributeGrid/AnimAmountBtn
@onready var coloration_btn = $ArtributeGrid/ColorationBtn

@onready var kolor_button = preload("res://UI/scenes/character_button.tscn")

signal color_changed(new_color: Color)
signal artribute_changed(arty_adjustment: Dictionary)

var current_color = [0, 0, 0]

func _ready():
	pass

func update_artribute_emojis():
	var button_list = artribute_grid.get_children()
	var art_btn_index = 0
	for keeword in Global.loaded_masterpiece['artributes']:
		if "Door" in keeword:
			button_list[art_btn_index].text = "🚪"
		elif "Window" in keeword:
			button_list[art_btn_index].text = "🪟"
		elif "Cloud" in keeword:
			button_list[art_btn_index].text = "☁️"
		elif "Rainbow" in keeword:
			button_list[art_btn_index].text = "🌈"
		elif "Fire" in keeword:
			button_list[art_btn_index].text = "🔥"
		elif "Ice" in keeword:
			button_list[art_btn_index].text = "🧊"
		elif "Camel" in keeword:
			button_list[art_btn_index].text = "🐫"
		elif "Chicken" in keeword:
			button_list[art_btn_index].text = "🐓"
		elif "Dog" in keeword:
			button_list[art_btn_index].text = "🐶"
		elif "Rock" in keeword:
			button_list[art_btn_index].text = "🗿"
		elif "Sock" in keeword:
			button_list[art_btn_index].text = "🧦"
		elif "Crayon" in keeword:
			button_list[art_btn_index].text = "🖍️"
		elif "Pen" in keeword:
			button_list[art_btn_index].text = "🖋"
		art_btn_index += 1
		if art_btn_index >= 6:
			art_btn_index = 0

func add_character_color_palette(char_symbol="F", color_array=['77', '192', '213']) -> Button:
	var new_char_color_btn = kolor_button.instantiate()
	new_char_color_btn.set_char_kolors(char_symbol, color_array)
	new_char_color_btn.pressed.connect(color_selected.bind(new_char_color_btn.kolor))
	return new_char_color_btn

func color_selected(new_color: Color):
	color_changed.emit(new_color)

func clear_color_palette():
	for child in color_rect_grid.get_children():
		child.queue_free()

func update_color_palette():
	clear_color_palette()
	useid_color_palette()

func useid_color_palette():
	for color in Global.loaded_masterpiece["color_list"]:
		var color_char_index = Global.loaded_masterpiece['color_list'].find(color)
		var new_color_btn = add_character_color_palette(Global.loaded_masterpiece['use_id'][color_char_index], color)
		color_rect_grid.add_child(new_color_btn)

func range_color_palette(num_colors: int):
	for i in range(num_colors):
		var color_char = Global.loaded_masterpiece['use_id'][Global.rng.randi() % Global.loaded_masterpiece['use_id'].length()]
		var new_color_btn = add_character_color_palette(color_char, Global.loaded_masterpiece['color_list'].pick_random())
		color_rect_grid.add_child(new_color_btn)

func masterpiece_updated():
	update_color_palette()
	update_artribute_emojis()

func _process(delta):
	pass

func _on_accuracy_btn_pressed():
	var artribute_adjustment = {"accuracy": 1}
	var cc = current_color
	if accuracy_btn.text == "🖍️":
		artribute_adjustment["accuracy"] = Global.rng.randf_range(0.8, 1.0)
	elif accuracy_btn.text == "🖋":
		artribute_adjustment["accuracy"] = Global.rng.randf_range(0.2, 0.4)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)
	#emit_signal("artribute_changed", artribute_adjustment)

func _on_transparency_btn_pressed():
	var artribute_adjustment = {"transparency": 0}
	var cc = current_color
	if transparency_btn.text == "🚪":
		artribute_adjustment["transparency"] = Global.rng.randf_range(0.8, 1.0)
	elif transparency_btn.text == "🪟":
		artribute_adjustment["transparency"] = Global.rng.randf_range(0.2, 0.4)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)

func _on_size_btn_pressed():
	var artribute_adjustment = {"size": 0}
	if size_btn.text == "🐓":
		artribute_adjustment["size"] = .25
		#artribute_adjustment["size"] = round_to_dec(Global.rng.randf_range(0.6, 0.8), 1)
	elif size_btn.text == "🐶":
		artribute_adjustment["size"] = .75
		#artribute_adjustment["size"] = round_to_dec(Global.rng.randf_range(0.9, 1.1), 1)
	elif size_btn.text == "🐫":
		artribute_adjustment["size"] = 1.25
		#artribute_adjustment["size"] = round_to_dec(Global.rng.randf_range(1.2, 1.4), 1)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)

func _on_anim_speed_btn_pressed() -> void:
	var artribute_adjustment = {"animation_speed": 0}
	if anim_speed_btn.text == "🔥":
		artribute_adjustment["animation_speed"] = .25
		#artribute_adjustment["animation_speed"] = round_to_dec(Global.rng.randf_range(0.6, 0.8), 1)
	elif anim_speed_btn.text == "🧊":
		artribute_adjustment["animation_speed"] = .75
		#artribute_adjustment["animation_speed"] = round_to_dec(Global.rng.randf_range(0.9, 1.1), 1)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)

func _on_anim_amount_btn_pressed() -> void:
	var artribute_adjustment = {"animation_amount": 0}
	if anim_amount_btn.text == "🗿":
		artribute_adjustment["animation_amount"] = .25
		#artribute_adjustment["animation_amount"] = round_to_dec(Global.rng.randf_range(0.6, 0.8), 1)
	elif anim_amount_btn.text == "🧦":
		artribute_adjustment["animation_amount"] = .75
		#artribute_adjustment["animation_amount"] = round_to_dec(Global.rng.randf_range(0.9, 1.1), 1)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)

func _on_coloration_btn_pressed() -> void:
	var artribute_adjustment = {"coloration": 0}
	if coloration_btn.text == "☁️":
		artribute_adjustment["coloration"] = .25
		#artribute_adjustment["coloration"] = round_to_dec(Global.rng.randf_range(0.6, 0.8), 1)
	elif coloration_btn.text == "🌈":
		artribute_adjustment["coloration"] = .75
		#artribute_adjustment["coloration"] = round_to_dec(Global.rng.randf_range(0.9, 1.1), 1)
	print("CAHB", artribute_adjustment)
	SignalBus.artribute_changed.emit(artribute_adjustment)
