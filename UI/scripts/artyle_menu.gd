extends MarginContainer

@onready var artyle_tabs = $Panel/ArtyleTabs
@onready var glyth_tab = $Panel/ArtyleTabs/Glyth
@onready var glyph_tab = $Panel/ArtyleTabs/Glyph
@onready var wordie_tab = $Panel/ArtyleTabs/Wordie
@onready var recipe_tab = $Panel/ArtyleTabs/Recipe
@onready var foto_tab = $Panel/ArtyleTabs/Foto
@onready var spirite_tab = $Panel/ArtyleTabs/Spirite

func _ready() -> void:
	SignalBus.switch_to_glyth.connect(update_glyth_tab)
	SignalBus.switch_to_glyph.connect(update_glyph_tab)
	SignalBus.switch_to_wordie.connect(update_wordie_tab)
	SignalBus.switch_to_recipe.connect(update_recipe_tab)
	SignalBus.switch_to_foto.connect(update_foto_tab)
	SignalBus.switch_to_spirite.connect(update_spirite_tab)
	SignalBus.masterpiece_changed.connect(update_all_artyles)



func update_all_artyles():
	print("updating_ALL")
	update_glyth_tab()
	update_glyph_tab()
	update_wordie_tab()
	update_recipe_tab()
	update_foto_tab()
	update_spirite_tab()
	
func update_glyth_tab():
	if "glyth" in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(0, false)
		glyth_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(0, true)
	
func update_glyph_tab():
	if 'glyph' in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(1, false)
		glyph_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(1, true)
	
func update_wordie_tab():
	if "wordie" in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(2, false)
		wordie_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(2, true)
	
func update_recipe_tab():
	if "recipe" in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(3, false)
		recipe_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(3, true)
	
func update_foto_tab():
	if "foto" in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(4, false)
		foto_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(4, true)
	
func update_spirite_tab():
	if "spirite" in Global.loaded_masterpiece:
		artyle_tabs.set_tab_disabled(5, false)
		spirite_tab.reload_tab_options()
	else:
		artyle_tabs.set_tab_disabled(5, true)

func _on_artyle_tabs_tab_selected(tab: int) -> void:
	if tab == 0:
		SignalBus.switch_to_glyth.emit()
	elif tab == 1:
		SignalBus.switch_to_glyph.emit()
	elif tab == 2:
		SignalBus.switch_to_wordie.emit()
	elif tab == 3:
		SignalBus.switch_to_recipe.emit()
	elif tab == 4:
		SignalBus.switch_to_foto.emit()
	elif tab == 5:
		SignalBus.switch_to_spirite.emit()
