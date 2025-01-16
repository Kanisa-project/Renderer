extends Node2D

@onready var artyle_menu = $ArtyleMenu
@onready var kinvow = $Kinvow

func _ready() -> void:
	#SignalBus.masterpiece_changed.connect(_on_masterpiece_menu_masterpiece_changed.bind({}))
	#_on_masterpiece_menu_masterpiece_changed({})
	pass
	
func _on_masterpiece_menu_masterpiece_changed(new_artyles: Dictionary) -> void:
	print("NEWART: ", new_artyles)
	artyle_menu.update_glyth_tab()
	artyle_menu.update_glyph_tab()
	artyle_menu.update_wordie_tab()
	artyle_menu.update_recipe_tab()
	artyle_menu.update_foto_tab()
