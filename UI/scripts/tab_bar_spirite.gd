extends "res://UI/scripts/tab_bar_artyle.gd"

@onready var layer_1_control = $HBoxContainer/spiriteLayerControl1
@onready var layer_2_control = $HBoxContainer/spiriteLayerControl2
@onready var layer_3_control = $HBoxContainer/spiriteLayerControl3
@onready var layer_4_control = $HBoxContainer/spiriteLayerControl4

var active_spirite = "Ball"
var spirite_layer_name_dict := {
	"Alien": ["body", "eyes", "mouth", "tentacles"],
	"Ball": ["base", "casing", "shade", "sparkles"],
	"Ship": ["nose", "body", "engine", "wings"],
	"Medallion": ["base", "cover", "decor", "triangle"],
	"Asteroid": ["core", "metal", "rock", "shell"],
	"Sword": ["blade", "hilt", 'charm', 'handle']
}

func _ready() -> void:
	layer_1_control.layer_number = 1
	layer_2_control.layer_number = 2
	layer_3_control.layer_number = 3
	layer_4_control.layer_number = 4
	update_layer_controls()

func update_layer_controls():
	layer_1_control.sprite_layers = layer_1_control.load_spirite_layers(active_spirite, spirite_layer_name_dict[active_spirite][0])
	layer_2_control.sprite_layers = layer_2_control.load_spirite_layers(active_spirite, spirite_layer_name_dict[active_spirite][1])
	layer_3_control.sprite_layers = layer_3_control.load_spirite_layers(active_spirite, spirite_layer_name_dict[active_spirite][2])
	layer_4_control.sprite_layers = layer_4_control.load_spirite_layers(active_spirite, spirite_layer_name_dict[active_spirite][3])

func change_active_spirite(new_spirite):
	#active_spirite = new_spirite
	if active_spirite == new_spirite:
		active_spirite = ["Medallion", "Ship", "Alien", "Ball", "Asteroid"].pick_random()
	else:
		active_spirite = new_spirite
	SignalBus.spirite_change_spirite.emit(active_spirite)

func reload_tab_options():
	super()
	if "spirite" in Global.loaded_masterpiece:
		active_spirite = Global.loaded_masterpiece['spirite'].keys()[0]
		update_layer_controls()
	
