extends MarginContainer

@onready var color_artributes = $Panel/MasterpieceVbox/ArtributeColorHbox
@onready var masterpiece_dropdown = $Panel/MasterpieceVbox/SelectionHbox/MasterpieceDropdown
@onready var gaym_choices_dropdown = $Panel/MasterpieceVbox/GaymsDropdown
@onready var tick_slider = $Panel/MasterpieceVbox/TimeHboxContainer/TickSpeedSlider
@onready var tock_slider = $Panel/MasterpieceVbox/TimeHboxContainer/TockSpeedSlider
@onready var tick_label = $Panel/MasterpieceVbox/TimeLabelHBoxContainer/TickLabel
@onready var tock_label = $Panel/MasterpieceVbox/TimeLabelHBoxContainer/TockLabel
@onready var tiock_label = $Panel/MasterpieceVbox/TimeLabelHBoxContainer/TiockLabel


var active_glyth_dict: Dictionary = {}
var gaym_choice_list := []

var rng = RandomNumberGenerator.new()

var GLYTH_GAYM_DICT = {
	"glyph": ["Break Out", "Qix"],
	"wordie": [],
	"recipe": [],
	"spirite": []
}
var GLYPH_GAYM_DICT = {
	"glyth": ["TicTacToe", "Tetris", "Snake"],
	"wordie": [],
	"recipe": [],
	"spirite": ["BattleShip"]
}
var WORDIE_GAYM_DICT = {
	"glyth": ["Hangman"],
	"glyph": ["Word Search", "Crossword"],
	"recipe": ["Recipe Book"],
	"spirite": []
}
var FOTO_GAYM_DICT = {
	"glyth": [],
	"glyph": ["Shuffle Puzzle", "Picross"],
	"wordie": [],
	"recipe": [],
	"spirite": []
}
var FULL_GAYM_DICT = {
	"glyth": GLYTH_GAYM_DICT,
	"glyph": GLYPH_GAYM_DICT,
	"recipe": {},
	"wordie": WORDIE_GAYM_DICT,
	"foto": FOTO_GAYM_DICT,
	"spirite": {},
}

func _ready():
	Global.loaded_masterpiece = Global.load_random_json_file("res://MASTERPIECEs/")
	rng.randomize()
	add_masterpieces_to_dropdown()
	SignalBus.masterpiece_changed.connect(add_gayms_to_dropdown)
	color_artributes.color_rect_grid.columns = 5
	_on_new_masterpiece_btn_pressed()

func _process(delta):
	pass

func _on_new_masterpiece_btn_pressed() -> void:
	var num_of_mstrpc = Global.fetch_masterpieces().size()
	var rnd_mstrpc = rng.randi_range(0, num_of_mstrpc - 1)
	var chosen_mstrpc = masterpiece_dropdown.get_item_text(rnd_mstrpc)
	Global.loaded_masterpiece = Global.load_json_file("res://MASTERPIECEs/" + chosen_mstrpc)
	masterpiece_dropdown.select(rnd_mstrpc)
	color_artributes.masterpiece_updated()
	SignalBus.masterpiece_changed.emit()

func add_masterpieces_to_dropdown() -> void:
	var masterpieces = Global.fetch_masterpieces()
	masterpiece_dropdown.clear()
	for mstrpc in masterpieces:
		masterpiece_dropdown.add_item(mstrpc)

func add_gayms_to_dropdown() -> void:
	var gaymss = gather_gaym_options()
	gaym_choices_dropdown.clear()
	for gayms in gaymss:
		for gaym in gayms:
			gaym_choices_dropdown.add_item(gaym)

func gather_gaym_options() -> Array:
	var gaym_options = []
	for prim_artyle in Global.loaded_masterpiece:
		if prim_artyle in ["glyth", "glyph", "wordie", "foto", "recipe", "spirite", "gaym", "mujic"]:
			for sec_artyle in FULL_GAYM_DICT[prim_artyle]:
				if sec_artyle in Global.loaded_masterpiece:
					gaym_options.append(FULL_GAYM_DICT[prim_artyle][sec_artyle])
	return gaym_options

func _on_masterpiece_dropdown_item_selected(index: int) -> void:
	Global.loaded_masterpiece = Global.load_json_file("res://MASTERPIECEs/" + masterpiece_dropdown.text)
	color_artributes.masterpiece_updated()
	SignalBus.masterpiece_changed.emit()

func _on_tick_speed_slider_drag_ended(value_changed: bool) -> void:
	SignalBus.masterpiece_update_tick.emit(value_changed, tick_slider.value)
	tick_label.text = "Tick: " + str(tick_slider.value)
	tiock_label.text = "Tiock: " + str(tick_slider.value + tock_slider.value)

func _on_tock_speed_slider_drag_ended(value_changed: bool) -> void:
	SignalBus.masterpiece_update_tock.emit(value_changed, tock_slider.value)
	tock_label.text = "Tock: " + str(tock_slider.value)
	tiock_label.text = "Tiock: " + str(tick_slider.value + tock_slider.value)
