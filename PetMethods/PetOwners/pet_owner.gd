extends CharacterBody2D

@onready var name_tag = $NameTag
@onready var whole_spirite = $Spirite
@onready var layer_1 = $Spirite/layerOne
@onready var layer_2 = $Spirite/layerTwo
@onready var layer_3 = $Spirite/layerThree
@onready var layer_4 = $Spirite/layerFour

var primary_cell_pos := Vector2(0, 0)
var secondary_cell_pos := Vector2(0, 0)
var thirdary_cell_pos := Vector2.ZERO

var owner_info: Dictionary
var favorite: Dictionary
var equipment: Dictionary
var RSG_stuff: Dictionary
var artribute_values: Dictionary

var speed = 150
var direction = Vector2.ZERO

var rng = RandomNumberGenerator.new()

var atHome := true
var atWork := false

var glyth_position_array = []
var glyph_position_array = []
var wordie_dictionaries = {}
var recipe_book = {}

func _ready() -> void:
	rng.randomize()
	SignalBus.artribute_changed.connect(update_artributes)
	
	owner_info = {
		"name": "Owen",
		"age": "42",
		"location": "kitchen",
		"occupation": "professor",
	}
	favorite = {
		"flower": "tulip",
		"color": "purple",
		"animal": "bat",
		"sport": "baseball",
		"soda": "pepsi",
		"drink": "kool-aid",
		"food": "pizza",
		"fruit": "grape",
		"vegetable": "eggplant"
	}

	equipment = {
		"head": "cheese wedge",
		"neck": "ghostspeak amulet",
		"torso": "plain blue t-shirt",
		"back": "nothing",
		"left hand": "sword",
		"right hand": "hammer",
		"legs": "sweat pants",
		"left foot": "flip flop",
		"right foot": "croc"
	}
	
	RSG_stuff = {
		'names': ['Tracy', 'Kevin', 'Roy', 'Pam', 'Meredith', 'Katrina', 'Karl', 'Michael', 'Adam', 'Danielle'],
		'colors': ['orange-red', 'navy blue', 'neon blue', 'brown', 'white', 'yellow', 'purple', 'light green', 'dark orange', 'neon pink'],
		'occupations': ['plumber', 'electrician', 'teacher', 'librarian', 'dentist', 'dishwasher', 'mechanic', 'jeweler', 'translator', 'judge'],
		'locations': ['vault', 'high school', 'main office', 'white house', 'steakhouse', 'grocery store', 'parking lot', 'space station', 'concert hall', 'GameStop'],
		'objects': ['controller', 'skateboard', 'football', 'computer', 'bottle', 'toy car', 'eraser', 'whiteboard', 'camera', 'table'],
		'ideas': ['conquest', 'democracy', 'communism', 'friendship', 'transaction', 'ownership', 'baking', 'vacation', 'photography', 'competition'],
		'drinks': ['coffee', 'gatorade', 'lemonade', 'whiskey', 'root beer', 'orange fanta', 'grape soda', 'water', 'chocolate milk', 'dishpit juice'],
		'food': ['cheesecake', 'apple', 'lemon', 'bread', 'churro', 'avocado', 'potato', 'potato chip', 'chocolate', 'dishpit salad']
	}
	
	artribute_values = {
		"accuracy": 0.0,
		"coloration": 0.0,
		"animation_speed": 0.0,
		"animation_amount": 0.0,
		"transparency": 0.0,
		"size": 0.0
	}

func nametag_switch_visible():
	name_tag.visible = !name_tag.visible

func update_artributes(new_art_values: Dictionary):
	for new_value in new_art_values.keys():
		artribute_values[new_value] = new_art_values[new_value]

func _process(delta: float) -> void:
	move_player(delta)

func gather_recipes_from_pets():
	recipe_book = {}

func update_color_scheme() -> void:
	layer_1.modulate = Global.primary_color
	layer_2.modulate = [Global.primary_color, Global.secondary_color].pick_random()
	layer_3.modulate = [Global.primary_color, Global.secondary_color].pick_random()
	layer_4.modulate = Global.thirdary_color

func build_spirite(layer_dict: Dictionary):
	layer_1.texture = layer_dict[layer_dict.keys()[0]].pick_random()
	layer_2.texture = layer_dict[layer_dict.keys()[1]].pick_random()
	layer_3.texture = layer_dict[layer_dict.keys()[2]].pick_random()
	layer_4.texture = layer_dict[layer_dict.keys()[3]].pick_random()

func move_player(delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()

func horizontal_direction(x_dir=0) -> Vector2:
	while x_dir == 0:
		x_dir = rng.randi_range(-1, 1)
	return Vector2(x_dir, 0)

func vertical_direction(y_dir=0) -> Vector2:
	while y_dir == 0:
		y_dir = rng.randi_range(-1, 1)
	return Vector2(0, y_dir)

#func pick_snake_direction(cur_dir: Vector2) -> Vector2:
	#var next_dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
	#while next_dir == -cur_dir:
		#next_dir = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT].pick_random()
	#return next_dir

func pick_random_direction() -> Vector2:
	var dir = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
	while dir == Vector2.ZERO:
		dir = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
	return dir

func scared():
	print(owner_info["name"] + " got scared.")

func alerted():
	print(owner_info["name"] + " is alerted.")

func annoyed():
	print(owner_info["name"] + " became annoyed..")

func take_leash() -> String:
	var new_hangman_phrase = owner_info['name'] + " drank some " + favorite['drink'] + ", and ate all of the " + favorite['food'] + "!?"
	return new_hangman_phrase

func go_walking(sides: int, offset: int, cx: int, cy: int, radius: int) -> Array:
	"""This is a desc."""
	var step = 2 * PI / sides
	var ophset = deg_to_rad(offset)
	var pointlist = []
	for n in range(0, int(sides) + 1):
		pointlist.append(Vector2(radius * cos(step * n + ophset) + cx, radius * sin(step * n + ophset) + cy))
	return pointlist

func go_running(rect_pos=Vector2(-60, -60), rect_size=Vector2(120, 120), pointlist_size=6) -> Array:
	"""This is a desc."""
	var pointlist = []
	for i in range(pointlist_size):
		var new_point = Vector2(rng.randi_range(rect_pos.x, rect_size.x), rng.randi_range(rect_pos.y, rect_size.y))
		pointlist.append(new_point)
	return pointlist

func play_tug_on_rope() -> Array:
	return []
	
	
#func play_tug_on_rope(pos_one: Vector2, pos_two: Vector2, pos_three: Vector2) -> Array:
	#var pointlist = [pos_one, pos_two, pos_three]
	#pointlist.append(pos_one + pos_two + pos_three)
	#return pointlist
