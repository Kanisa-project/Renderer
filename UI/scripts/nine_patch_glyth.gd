extends "res://UI/scripts/nine_patch_artyle.gd"

@onready var shader_material = material as ShaderMaterial
@onready var Bethany = $OwnerBethany
@onready var Susan = $OwnerSusan
@onready var Justin = $OwnerJustin
@onready var Jacob = $OwnerJacob
#@onready var Robert = $OwnerRobert

var trail_points := []
var a_point := Vector2(142, 316)
var b_point := Vector2(382, 16)
var c_point := Vector2(612, 396)
var d_point := Vector2(293, 49)
var e_point := Vector2(23, 349)
var number_of_ticks = 0
var appointed_list
var active_glyths = []

func _ready() -> void:
	SignalBus.base_color_changed.connect(change_base_color)
	SignalBus.glyth_change_active.connect(collect_active_glyths)
	appointed_list = Justin.go_walking(12, 0, 370, 210, 169)
	set_owner_starting_points()
	
func set_owner_starting_points():
	Bethany.position = Vector2(-360, 250)
	Jacob.position = Vector2(-360, 350)
	Justin.position = Vector2(-240, 350)
	Susan.position = Vector2(-240, 250)

func next_point() -> void:
	if b_point.y >= 0:
		b_point = Susan.Snowball.run_wheel_down(b_point)
	elif b_point.y >= 10:
		b_point = Susan.Snowball.run_wheel_up(b_point)

func collect_active_glyths(available_glyths: Array) -> void:
	active_glyths = []
	for avail_glyth in available_glyths:
		active_glyths.append(avail_glyth)

func change_base_color(newColor: Color):
	print('changing color to ', newColor)
	#modulate = newColor

func _process(delta: float) -> void:
	pass

func set_the_speeds() -> void:
	var base_speed = Global.loaded_masterpiece['number_list'][3]
	Jacob.speed = base_speed * 50
	#Bethany.speed = base_speed * 40
	#Robert.speed = base_speed * 30
	#Justin.speed = base_speed * 20
	Susan.speed = base_speed * 50

func color_the_layers() -> void:
	Jacob.update_color_scheme()
	#Robert.update_color_scheme()
	Susan.update_color_scheme()
	#Justin.update_color_scheme()

func follow_track_points(points_array: Array):
	for point in points_array:
		stay_on_track(point, point)

func stay_on_track(track_p1: Vector2, track_p2: Vector2) -> Vector2:
	return track_p1.direction_to(track_p2)

func draw_ball(center_pos: Vector2, ball_size=2) -> void:
	draw_circle(center_pos, ball_size, [Global.thirdary_color, Global.primary_color, Global.secondary_color].pick_random())

func draw_horizontal_line(start_pos: Vector2, line_size=1) -> void:
	var end_pos = start_pos + Vector2(line_size, 0)
	draw_line(start_pos, end_pos, [Global.primary_color, Global.secondary_color].pick_random(), (line_size % 10) + 1)

func draw_vertical_line(start_pos: Vector2, line_size=1) -> void:
	var end_pos = start_pos + Vector2(0, line_size)
	draw_line(start_pos, end_pos, [Global.secondary_color, Global.thirdary_color].pick_random(), (line_size % 10) + 1)

func draw_verticle_zigzag_line(start_pos: Vector2, spreading: Vector2, line_size=1, num_of_zigzag=10) -> void:
	var prev_pos = start_pos
	var zig_zag_points = []
	var zig = spreading
	var zag = Vector2(spreading.x*-1, spreading.y)
	var line_colors = []
	for i in range(num_of_zigzag):
		if i % 2 == 0:
			var next_zig = zig + prev_pos
			zig_zag_points.append(next_zig)
			line_colors.append([Global.primary_color, Global.secondary_color, Global.thirdary_color].pick_random())
			prev_pos = next_zig
		else:
			var next_zag = zag + prev_pos
			zig_zag_points.append(next_zag)
			line_colors.append([Global.primary_color, Global.secondary_color, Global.thirdary_color].pick_random())
			prev_pos = next_zag
	draw_polyline_colors(zig_zag_points, line_colors, line_size)

func draw_horizontal_zigzag_line(start_pos: Vector2, spreading: Vector2, line_size=1, num_of_zigzag=10) -> void:
	var prev_pos = start_pos
	var zig_zag_points = []
	var zig = spreading
	var zag = Vector2(spreading.x, spreading.y*-1)
	var line_colors = []
	for i in range(num_of_zigzag):
		if i % 2 == 0:
			var next_zig = zig + prev_pos
			zig_zag_points.append(next_zig)
			line_colors.append([Global.primary_color, Global.secondary_color, Global.thirdary_color].pick_random())
			prev_pos = next_zig
		else:
			var next_zag = zag + prev_pos
			zig_zag_points.append(next_zag)
			line_colors.append([Global.primary_color, Global.secondary_color, Global.thirdary_color].pick_random())
			prev_pos = next_zag
	draw_polyline_colors(zig_zag_points, line_colors, line_size)

func draw_diagonal_line() -> void:
	pass

func _on_tick_timer_timeout() -> void:
	number_of_ticks += 1
	set_the_speeds()
	color_the_layers()
	#queue_redraw()
	Jacob.direction = stay_on_track(Jacob.position, [a_point, b_point, c_point][number_of_ticks % 3])
	Susan.direction = stay_on_track(Susan.position, b_point)
	Justin.direction = stay_on_track(Justin.position, appointed_list[number_of_ticks % 6])
	Bethany.direction = stay_on_track(Bethany.position, appointed_list[number_of_ticks % 4])

func _on_tock_timer_timeout() -> void:
	for active_glyth in active_glyths:
		match active_glyth:
			"Confetti":
				Jacob.nametag_switch_visible()
				Jacob.queue_redraw()
			"Ripples":
				Justin.nametag_switch_visible()
				Justin.queue_redraw()
			"Circle Shapes":
				Susan.nametag_switch_visible()
				Susan.queue_redraw()
			"Box Lines":
				Bethany.nametag_switch_visible()
				Bethany.queue_redraw()
	#queue_redraw()

func _draw() -> void:
	Jacob.queue_redraw()
	Justin.queue_redraw()
	Susan.queue_redraw()
	Bethany.queue_redraw()
