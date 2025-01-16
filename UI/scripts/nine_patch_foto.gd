extends "res://UI/scripts/nine_patch_artyle.gd"

@onready var shader_material = material as ShaderMaterial
@onready var Bethany = $OwnerBethany
@onready var pic0 = preload("res://Fotoes/landscape0.JPG")
@onready var pic1 = preload("res://Fotoes/landscape1.JPG")
@onready var pic2 = preload("res://Fotoes/landscape2.JPG")
@onready var pic3 = preload("res://Fotoes/landscape3.JPG")
@onready var pic4 = preload("res://Fotoes/landscape4.JPG")
@onready var pic5 = preload("res://Fotoes/landscape5.JPG")
#@onready var pic6 = preload("res://Fotoes/landscape6.JPG")
@onready var pic7 = preload("res://Fotoes/landscape7.JPG")
#@onready var pic8 = preload("res://Fotoes/landscape8.JPG")
@onready var pic9 = preload("res://Fotoes/landscape9.JPG")
@onready var tiock_timer = $tiockTimer

var pic_array := []
var loaded_pic
var tiock_speed = 0
var foto_index = 0
var HSB_floats = [0.0, 0.0, 0.0]
var RGB_floats = [0.0, 0.0, 0.0]
var tock_output_dict = {}

func _ready() -> void:
	var loaded_pic = pic0
	pic_array = [pic0, pic1, pic2, pic3, pic4, pic5, pic5, pic7, pic5, pic9]
	SignalBus.masterpiece_update_tick.connect(tick_sync_tock)
	SignalBus.masterpiece_update_tock.connect(tick_sync_tock)
	SignalBus.foto_prev.connect(change_to_prev_foto)
	SignalBus.foto_next.connect(change_to_next_foto)
	SignalBus.foto_change_input_dict.connect(update_tock_output_dict)
	Bethany.position = Vector2(-360, 250)
	tock_output_dict = {
		'hue': 0.0,
		'saturation': 0.0,
		'brightness': 0.0,
		'red': 0.0,
		'green': 0.0,
		'blue': 0.0
	}
	

func update_tock_output_dict(new_input_dict: Dictionary):
	tock_output_dict = new_input_dict

func tick_sync_tock(something, or_more) -> void:
	tiock_speed = tick_timer.wait_time + tock_timer.wait_time
	tiock_timer.wait_time = tiock_speed

func _on_tick_timer_timeout() -> void:
	#loaded_pic = pic_array.pick_random()
	#texture = loaded_pic
	#modulate = Global.thirdary_color
	#var margin_num = 10
	#var margin_num = Bethany.Smokey.purr() * Global.loaded_masterpiece["number_list"].pick_random()
	pass

func change_to_next_foto():
	loaded_pic = pic_array[clamp_foto_index()]
	texture = loaded_pic
	
func change_to_prev_foto():
	loaded_pic = pic_array[clamp_foto_index(-1)]
	texture = loaded_pic

func set_foto_zoom():
	var foto_width = 430 * Global.loaded_masterpiece["number_list"].pick_random()
	var foto_height = 288 * Global.loaded_masterpiece["number_list"].pick_random()
	#region_rect = Rect2(0, 0, foto_width, foto_width)
	region_rect = Rect2(0, 0, 3872, 2592)

func set_margin_corners(margin_num=10):
	patch_margin_top = margin_num
	patch_margin_left = margin_num
	patch_margin_right = margin_num
	patch_margin_bottom = margin_num

func _on_tock_timer_timeout() -> void:
	pass
	

func update_HSB_float_array(new_floats: Array):
	HSB_floats = new_floats

func set_hsv_shader() -> void:
	shader_material.set_shader_parameter("h", tock_output_dict['hue']/100)
	shader_material.set_shader_parameter("s", tock_output_dict['saturation']/100)
	shader_material.set_shader_parameter("b", tock_output_dict['brightness']/100)


func set_rgb_blend() -> void:
	shader_material.set_shader_parameter("r", tock_output_dict['red']/100)
	shader_material.set_shader_parameter("g", tock_output_dict['green']/100)
	shader_material.set_shader_parameter("u", tock_output_dict['blue']/100)


func _on_tiock_timer_timeout() -> void:
	set_hsv_shader()
	set_rgb_blend()
	set_foto_zoom()
	set_margin_corners(Bethany.Smokey.purr() * Global.loaded_masterpiece["number_list"].pick_random())

func clamp_foto_index(index_dir=1) -> int:
	foto_index += index_dir
	if foto_index >= pic_array.size():
		foto_index = 0
	elif foto_index <= 0:
		foto_index = pic_array.size() - 1
	return foto_index
