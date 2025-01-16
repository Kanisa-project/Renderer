extends "res://PetMethods/PetOwners/pet_owner.gd"

@onready var Tucker = $MethodTucker
#@onready var Buster = $BusterMethod
#@onready var Beamy = $BeamyMethod


func _ready() -> void:
	super()
	scale = Vector2(.5, .5)
	owner_info = {
		"name": "Susan",
		"age": "38",
		"location": "Youngstown",
		"occupation": "stylist"
	}

	favorite = {
		"flower": "sativa",
		"color": "green",
		"animal": "frog",
		"sport": "darts",
		"soda": "root beer",
		"drink": "sweet coffee",
		"food": "pizza",
		"fruit": "apple",
		"vegetable": "broccoli"
	}

	equipment = {
		"head": "nothing",
		"neck": "dragonfly amulet",
		"torso": "whistlin' jack jacket",
		"back": "nothing",
		"left hand": "bong",
		"right hand": "blunt",
		"legs": "shorts",
		"left foot": "sandal",
		"right foot": "sandal"
	}
	
	RSG_stuff = {
		"names": ["Greg", "Brittany", "Tyrese", "Ashley", "Jose", "Chloe", "Andrew", "Misty", "Brett", "Hailey"],
		"colors": ["mint green", "yellow", "green", "tan", "orange", "blue-black", "violet", "white", "gray", "blue"],
		"occupations": ['hair stylist', 'bartender', 'mechanic', 'carpenter', 'doctor', 'therapist', 'musician', 'baker', 'fisherman', 'firefighter'],
		"locations": ['Yakima', 'Canton', 'Portland', 'Las Vegas', 'Akron', 'Ellensburg', 'New York', 'Tulsa', 'Phoenix', 'New Orleans']
	}
	
	var games = ['tetris', 'battleship', "tic-tac-toe", "dots", "word search", "hangman"]
	Tucker.set_minor_points(go_walking(9, 0, 0, 0, 174))
	Tucker.set_major_points(go_walking(6, 120, 0, 0, 48))

func _process(delta: float) -> void:
	Tucker.minor_rotation += .735
	Tucker.major_rotation += .632
	
func _draw() -> void:
	var do_what = play_tug_on_rope()
	if do_what[0]:
		draw_circle_shapes(Vector2.ZERO)
	if do_what[1]:
		pass
	else:
		draw_line(Vector2.ZERO, Vector2.ONE, Color.WHITE)


func play_tug_on_rope() -> Array:
	Tucker.hasToy = false
	if not Tucker.isTired:
		Tucker.tiredness += 2
		if Tucker.tiredness >= Tucker.max_tiredness:
			Tucker.isTired = true
	else:
		Tucker.tiredness -= 2
		if Tucker.tiredness <= 0:
			Tucker.isTired = false
	return [Tucker.isTired, Tucker.hasToy]


func glyph_drawing() -> void:
	primary_cell_pos = Vector2.ONE

func glyth_drawing() -> void:
	for point in Tucker.minor_points:
		draw_circle(point, 8, Global.primary_color, false, 3)
		for point2 in go_walking(6, Tucker.minor_rotation, point[0], point[1], 62):
			draw_circle_shapes(point2)

func draw_circle_shapes(shape_pos: Vector2) -> void:
	for point in Tucker.major_points:
		draw_circle(shape_pos, 31, Global.primary_color, false, 3)
		draw_line(shape_pos, point, Global.thirdary_color, 3)
