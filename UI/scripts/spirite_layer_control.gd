extends Control

@onready var sprite_layer = $VBox/layerTexture
@onready var layer_name = $VBox/layerName
@onready var arty_colo_hbox = $VBox/ArtributeColorHbox

var layer_number = 0
var sprite_layers = []
var selected_index = 0
var selected_color = Color(0.0, 0.0, 0.0)
var name_spirite = "Ball"
var name_layer = "base"


func _ready() -> void:
	update_colors()
	#SignalBus.spirite_layer_color_changed.connect(update_layer_color)



func update_colors() -> void:
	arty_colo_hbox.clear_color_palette()
	arty_colo_hbox.range_color_palette(6)
	#arty_colo_hbox.color_changed.connect(update_layer_color)

func _on_prev_btn_pressed() -> void:
	if selected_index <= 0:
		selected_index = 9
	else:
		selected_index -= 1
	update_layer_sprite()


func _on_rand_btn_pressed() -> void:
	selected_index = Global.rng.randi_range(0, 9)
	update_layer_sprite()

func _on_next_btn_pressed() -> void:
	if selected_index >= 9:
		selected_index = 0
	else:
		selected_index += 1
	update_layer_sprite()

#func update_layer_color(new_color: Color):
	#print(layer_number, new_color)
	#SignalBus.spirite_layer_color_changed.emit(layer_number, new_color)
	#sprite_layer.modulate = new_color

func update_layer_sprite():
	layer_name.text = name_spirite + "/" + name_layer + str(selected_index) + ".png"
	sprite_layer.texture = sprite_layers[selected_index]
	SignalBus.spirite_layer_sprite_changed.emit(layer_number, sprite_layers[selected_index])

func load_spirite_layers(spirite_name: String, layer_name: String) -> Array:
	name_spirite = spirite_name
	name_layer = layer_name
	var new_spirite_layers = []
	var layers_path = "res://Spirites/" + spirite_name + "/" + layer_name 
	for i in range(10):
		var spirite = load(layers_path + str(i) + ".png")
		new_spirite_layers.append(spirite)
		sprite_layer.texture = spirite
	return new_spirite_layers

#func change_layer_sprite():
	#sprite_layer.texture = sprite_layers[selected_index]


func _on_artribute_color_hbox_color_changed(new_color: Color) -> void:
	print(layer_number, new_color)
	SignalBus.spirite_layer_color_changed.emit(layer_number, new_color)
	sprite_layer.modulate = new_color


func _on_artribute_color_hbox_artribute_changed(arty_adjustment: Dictionary) -> void:
	pass # Replace with function body.
