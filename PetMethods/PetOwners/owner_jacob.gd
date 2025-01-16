extends "res://PetMethods/PetOwners/pet_owner.gd"

@onready var NameTag = $NameTag
@onready var Buster = $MethodBuster

var tugRope = false

func _ready() -> void:
	super()
	scale = Vector2(.5, .5)
	owner_info = {
		"name": "Jacob",
		"age": "16",
		"location": "grandmas",
		"occupation": "agriculture mechanic",
	}

	favorite = {
		"flower": "Hybrid",
		"color": "blue",
		"animal": "cheetah",
		"sport": "baseball",
		"soda": "root beer",
		"drink": "water",
		"food": "pizza",
		"fruit": "grape",
		"vegetable": "carrot"
	}

	equipment = {
		"head": "beanie",
		"neck": "amulet of defence",
		"torso": "sweet dreams t-shirt",
		"back": "backpack",
		"left hand": "ps4 controller",
		"right hand": "ps4 controller",
		"legs": "sweat pants",
		"left foot": "Air Bethany",
		"right foot": "Air Bethany"
	}

	RSG_stuff = {
		"names": ["Aurora", "Kensi", "Billy", "Bob", "Joe", "David", "Jhon", "Tom", "Jasson", "Bret"],
		"colors": ["purple", "blue", "green", "indigo", "black", "red", "silver", "gold", "brown", "teal"],
		"occupations": ['construction electrician', 'fisherman', 'bus driver', 'cab driver', 'wedding planner', 'basketball player', 'uber driver', 'baseball player', 'card dealer', 'dish washer'],
		'locations': ['New Mexico', 'Portland', 'McDonald\'s', 'Ohio', 'Greenland', '13th street', 'London bakery', 'Crumbl Cookie', 'Jamba Juice', 'MODs pizza']
	}
	
	Buster.set_minor_points(go_walking(10, 0, 0, 0, 75))
	Buster.set_major_points(go_walking(3, 60, 0, 0, 18))
	#position = Vector2(370, 210)

func _process(delta: float) -> void:
	#direction = pick_random_direction()
	#move_player(delta)
	#play_tug_on_rope()
	#Buster.drinks("water")
	pass

func refill_blues_water() -> Array:
	if Buster.isThirsty:
		Buster.drink(true)
	else:
		Buster.potty()
	return [Buster.isThirsty]

func play_tug_on_rope() -> Array:
	if not Buster.isTired:
		Buster.tug_on_rope()
	else:
		Buster.rest()
	return [Buster.isTired, Buster.hasToy]
	
func feed_blue() -> Array:
	if Buster.isHungry:
		Buster.eat(true, 6)
	else:
		Buster.potty()
	return [Buster.isHungry]

func _draw() -> void:
	var do_what = play_tug_on_rope()
	feed_blue()
	refill_blues_water()
	#var do_what = feed_blue()
	if do_what[0]:
		draw_confetti_large_area()
	#if do_what[1]:
		#draw_confetti_small_area()
	else:
		draw_line(Vector2.ZERO, Vector2.ONE, Color.WHITE)

func glyph_drawing():
	primary_cell_pos = Vector2.ZERO

func glyth_drawing():
	draw_confetti_large_area()
	
func draw_confetti_large_area():
	for point in Buster.major_points:
		for point2 in go_walking(4, 45, point[0], point[1], Buster.minor_rotation):
			draw_confetti_lines(point2, 3, 6, 9, 5)
			#draw_line(point, point2, Global.secondary_color, Global.loaded_masterpiece['number_list'].pick_random())

func draw_confetti_small_area():
	for point in Buster.minor_points:
		for point2 in go_walking(4, 75, point[0], point[1], Buster.minor_rotation):
			draw_confetti_lines(point2, 3, 6, 9, 5)
			#draw_line(point, point2, Global.secondary_color, Global.loaded_masterpiece['number_list'].pick_random())

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

func draw_confetti_lines(center_point: Vector2, a: int, b: int, c: int, d: int) -> void:
	var fetti_spreading = Buster.bark_bark(-9, 9, -9, 9)
	#draw_circle(center_point, 2, Global.primary_color)
	draw_horizontal_zigzag_line(center_point + Vector2(-a, b)*(randi_range(-500, 500)%10), fetti_spreading+Vector2(-a, b), 2, a)
	draw_verticle_zigzag_line(center_point + Vector2(c, -d)*(randi_range(-500, 500)%10), fetti_spreading+Vector2(c, -b), 2, b)
	draw_horizontal_zigzag_line(center_point + Vector2(c, -b)*(randi_range(-500, 500)%10), fetti_spreading+Vector2(a, c), 2, b)
	draw_verticle_zigzag_line(center_point + Vector2(a, -d)*(randi_range(-500, 500)%10), fetti_spreading+Vector2(-d, d), 2, d)
	draw_horizontal_zigzag_line(center_point + Vector2(-b, c)*(randi_range(-500, 500)%10), fetti_spreading+Vector2(-b, -c), 2, c)
