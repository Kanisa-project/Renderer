extends "res://UI/scripts/tab_bar_artyle.gd"

@onready var alphabet_grid = $AlphabetBtnGrid

var reading_time_length = 3

func _ready() -> void:
	super()
	reset_single_letter_buttons()

func letter_button_clicked(ltr_btn_clicked: Button):
	#SignalBus.hangman_guess_letter.emit(ltr_btn_clicked.text)
	ltr_btn_clicked.disabled = true

func create_letter_button(character: String) -> Button:
	var new_ltr_btn = add_text_button(character)
	new_ltr_btn.pressed.connect(letter_button_clicked.bind(new_ltr_btn))
	return new_ltr_btn

func reload_tab_options():
	super()
	if "wordie" in Global.loaded_masterpiece:
		reset_single_letter_buttons()

func reset_single_letter_buttons():
	for btn in alphabet_grid.get_children():
		btn.queue_free()
	for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
		alphabet_grid.add_child(create_letter_button(char))

func _on_new_gaym_btn_pressed() -> void:
	pass # Replace with function body.
