extends Node2D

@onready var glyth_bg = $NinePatchGlyth
@onready var glyph_fg = $NinePatchGlyph
@onready var wordie_gaym = $NinePatchWordie
@onready var recipe_text = $NinePatchRecipe
@onready var foto_patch = $NinePatchFoto
@onready var spirite_wind = $NinePatchSpirite

var tick_speed = 2
var tock_speed = .2

func _ready() -> void:
	SignalBus.switch_to_glyth.connect(view_glyth)
	SignalBus.switch_to_glyph.connect(view_glyph)
	SignalBus.switch_to_wordie.connect(view_wordie)
	SignalBus.switch_to_recipe.connect(view_recipe)
	SignalBus.switch_to_foto.connect(view_foto)
	SignalBus.switch_to_spirite.connect(view_spirite)
	SignalBus.masterpiece_update_tick.connect(update_tick_speeds)
	SignalBus.masterpiece_update_tock.connect(update_tock_speeds)
	#SignalBus.masterpiece_changed.connect()

func _draw() -> void:
	pass

func update_tick_speeds(something, new_speed):
	for child in get_children():
		child.update_tick_speed(something, new_speed)

func update_tock_speeds(something, new_speed):
	for child in get_children():
		child.update_tock_speed(something, new_speed)

func _on_redraw_same_btn_pressed() -> void:
	glyth_bg.take_blue_potty()

func _on_redraw_new_btn_pressed() -> void:
	glyth_bg.feed_blue()

func view_glyth():
	glyth_bg.show()
	glyph_fg.hide()
	wordie_gaym.hide()
	recipe_text.hide()
	foto_patch.hide()
	spirite_wind.hide()

func view_glyph():
	glyth_bg.hide()
	glyph_fg.show()
	wordie_gaym.hide()
	recipe_text.hide()
	foto_patch.hide()
	spirite_wind.hide()

func view_wordie():
	glyth_bg.hide()
	glyph_fg.hide()
	wordie_gaym.show()
	recipe_text.hide()
	foto_patch.hide()
	spirite_wind.hide()

func view_recipe():
	glyth_bg.hide()
	glyph_fg.hide()
	wordie_gaym.hide()
	recipe_text.show()
	foto_patch.hide()
	spirite_wind.hide()

func view_foto():
	glyth_bg.hide()
	glyph_fg.hide()
	wordie_gaym.hide()
	recipe_text.hide()
	foto_patch.show()
	spirite_wind.hide()

func view_spirite():
	glyth_bg.hide()
	glyph_fg.hide()
	wordie_gaym.hide()
	recipe_text.hide()
	foto_patch.hide()
	spirite_wind.show()
