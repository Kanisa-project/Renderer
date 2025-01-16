extends "res://UI/scripts/nine_patch_artyle.gd"

@onready var spirite = $Spirite
@onready var layer_one = $Spirite/layerOne
@onready var layer_two = $Spirite/layerTwo
@onready var layer_three = $Spirite/layerThree
@onready var layer_four = $Spirite/layerFour


#var active_spirite_part_dict := {}
var spirite_layer_name_dict := {
	"Alien": ["body", "eyes", "mouth", "tentacles"],
	"Ball": ["base", "casing", "shade", "sparkles"],
	"Ship": ["nose", "body", "engine", "wings"],
	"Medallion": ["base", "cover", "decor", "triangle"],
	"Asteroid": ["core", "metal", "rock", "shell"],
	"Sword": ["blade", "hilt", 'charm', 'handle']
}

var active_spirite := "Alien"
#var isCycling := false


func _ready() -> void:
	#active_spirite_part_dict = load_spirite_layers(active_spirite, spirite_layer_name_dict[active_spirite])
	SignalBus.primary_color_changed.connect(update_primary_color)
	SignalBus.secondary_color_changed.connect(update_secondary_color)
	SignalBus.thirdary_color_changed.connect(update_thirdary_color)
	#SignalBus.spirite_switch_cycling.connect(switch_cycling)
	#SignalBus.spirite_change_spirite.connect(set_active_spirite)
	SignalBus.spirite_layer_sprite_changed.connect(update_spirite)
	SignalBus.spirite_layer_color_changed.connect(update_colors)

func update_colors(layer_num: int, new_color: Color):
	print(layer_num)
	if layer_num == 1:
		layer_one.modulate = new_color
	if layer_num == 2:
		layer_two.modulate = new_color
	if layer_num == 3:
		layer_three.modulate = new_color
	if layer_num == 4:
		layer_four.modulate = new_color

func update_spirite(layer_num: int, new_layer: Texture):
	if layer_num == 1:
		layer_one.texture = new_layer
	if layer_num == 2:
		layer_two.texture = new_layer
	if layer_num == 3:
		layer_three.texture = new_layer
	if layer_num == 4:
		layer_four.texture = new_layer

func update_primary_color(new_color: Color):
	#layer_one.modulate = new_color
	pass
	
func update_secondary_color(new_color: Color):
	#layer_two.modulate = new_color
	pass
	
func update_thirdary_color(new_color: Color):
	#layer_three.modulate = new_color
	pass

#func switch_cycling() -> void:
	#isCycling = !isCycling
	
#func change_spirite(new_spirite) -> void:
	#active_spirite = new_spirite
	#active_spirite_part_dict = load_spirite_layers(new_spirite, spirite_layer_name_dict[new_sp])
	#print("spirite_changed")

func load_spirite_layers(spirite_object: String, layer_names: Array) -> Dictionary:
	var spirite_layer_dict := {}
	for layer_name in layer_names:
		var layer_array := []
		for i in range(10):
			var layer_num = layer_name + str(i)
			var spirite_path = "res://Spirites/" + spirite_object + "/" + layer_num + ".png"
			var new_part = load(spirite_path)
			layer_array.append(new_part)
		spirite_layer_dict[layer_name] = layer_array
	return spirite_layer_dict

#func set_active_spirite(new_spirite: String) -> void:
	#active_spirite = new_spirite
	#active_spirite_part_dict = load_spirite_layers(new_spirite, spirite_layer_name_dict[new_spirite])

func _on_tick_timer_timeout() -> void:
	pass
