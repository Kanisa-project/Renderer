extends "res://PetMethods/PetOwners/pet_owner.gd"

@onready var Beamy = $MethodBeamy


func _ready() -> void:
	super()
	scale = Vector2(.5, .5)
	owner_info = {
		"name": "Justin",
		"age": "34",
		"location": "bedroom",
		"occupation": "dish washer",
	}

	favorite = {
		"flower": "Hybrid",
		"color": "blue",
		"animal": "owl",
		"sport": "soccer",
		"soda": "root beer",
		"drink": "water",
		"food": "pizza",
		"fruit": "cantaloupe",
		"vegetable": "potato"
	}

	equipment = {
		"head": "one piece beanie",
		"neck": "amulet of accuracy",
		"torso": "O'neil jacket",
		"back": "camera bag",
		"left hand": "keyboard",
		"right hand": "mouse",
		"legs": "blue jeans",
		"left foot": "sock",
		"right foot": "sock"
	}

	RSG_stuff = {
		"names": ["Kevin", "Kyle", "Brittany", "Barbara", "Jack", "Daniel", "Jackie", "Tara", "Jennifer", "Brandon"],
		"colors": ["blue", "purple", "yellow", "violet", "brown", "red", "teal", "white", "tan", "scarlet"],
		'locations': ['Varrock', 'Azeroth', 'Michigan', 'Ohio', 'Ireland', 'school', 'Wales', 'Wendy\'s', 'dumpster', 'public library'],
		"occupations": ['librarian', 'coal miner', 'bus driver', 'dog trainer', 'high school teacher', 'barista', 'farmer', 'technician', 'police officer', 'dish washer'],
		'objects': ['quartz crystal', 'salt shaker', 'fidget spinner', 'chunk of obsidian', 'chisel', 'sapphire', 'amulet of defence', 'beanie', 'car keys', 'deck of cards'],
		'ideas': ['mining', 'cooking', 'fishing', 'fletching', 'praying', 'selling', 'buying', 'sleeping', 'contemplation', 'crafting'],
		'drinks': ['orange juice', 'iced tea', 'sun tea', 'coffee', 'water', 'red bull', 'tequila sunrise', 'strawberry lemonade', 'tomato juice', 'iced latte'],
		'foods': ['hawaiian pizza', 'roasted duck', 'apple', 'potato soup', 'jackfruit', 'rice', 'beef shtoe', 'PBnJ', 'macaroni and cheese', 'spaghetti']
	}
	
	Beamy.set_minor_points(go_walking(9, 0, 0, 0, 160))
	Beamy.set_major_points(go_walking(3, 60, 0, 0, 42))


func _process(delta: float) -> void:
	Beamy.minor_rotation += .51

func _draw() -> void:
	var do_what = play_tug_on_rope()
	if do_what[0]:
		triple_ripple()
	if do_what[1]:
		pass
	else:
		draw_line(Vector2.ZERO, Vector2.ONE, Color.WHITE)

func glyph_drawing():
	primary_cell_pos = Vector2.ONE

func play_tug_on_rope() -> Array:
	if not Beamy.isTired:
		Beamy.tug_on_rope()
	else:
		Beamy.rest()
	return [Beamy.isTired, Beamy.hasToy]

func glyth_drawing():
	pass
	
func pick_snake_direction(cur_dir: Vector2) -> Vector2:
	var next_dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
	while next_dir == -cur_dir:
		next_dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
	return next_dir

func triple_ripple():
	for point in Beamy.minor_points:
		for point2 in go_walking(4, Beamy.minor_rotation, point[0], point[1], int(Beamy.minor_rotation) % 142):
			draw_ripple_circles(point2, Global.loaded_masterpiece['number_list'].pick_random(), 8)


func draw_ripple_circles(center_pos: Vector2, start_size=2, ripple_spacing=16) -> void:
	var coloring = [Global.thirdary_color, Global.secondary_color, Global.primary_color]
	for i in range(Global.loaded_masterpiece['number_list'][9]):
		draw_circle(center_pos, ripple_spacing * i, coloring.pick_random(), false, start_size)
