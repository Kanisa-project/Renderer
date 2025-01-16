extends "res://PetMethods/PetOwners/pet_owner.gd"

@onready var Smokey = $MethodSmokey
@onready var Beamy = $MethodBeamy


func _ready() -> void:
	scale = Vector2(.5, .5)
	gather_recipes_from_pets()
	Smokey.set_minor_points(go_walking(10, 0, 0, 0, 84))
	Smokey.set_major_points(go_walking(4, 90, 0, 0, 31))

func gather_recipes_from_pets() -> void:
	#for recipe in Buster.SOUP_RECIPE_DICT.keys():
		#recipe_book[recipe] = Buster.SOUP_RECIPE_DICT[recipe]
	for recipe in Beamy.SANDWICH_RECIPE_DICT.keys():
		recipe_book[recipe] = Beamy.SANDWICH_RECIPE_DICT[recipe]
	for recipe in Smokey.SEASONING_RECIPE_DICT.keys():
		recipe_book[recipe] = Smokey.SEASONING_RECIPE_DICT[recipe]

func _process(delta: float) -> void:
	#move_player(delta)
	play_tug_on_rope()
	Smokey.minor_rotation += .51


func _draw() -> void:
	var do_what = play_tug_on_rope()
	feed_smokey()
	if do_what[0]:
		draw_box_lines()
	if do_what[1]:
		pass
	else:
		draw_line(Vector2.ZERO, Vector2.ONE, Color.WHITE)

func feed_smokey() -> Array:
	if Smokey.isHungry:
		Smokey.eat(true, 30)
	return [Smokey.isHungry]
	
func refill_smokeys_water() -> Array:
	return [Smokey.isThirsty]

func play_tug_on_rope() -> Array:
	Smokey.hasToy = false
	if not Smokey.isTired:
		Smokey.tiredness += 2
		if Smokey.tiredness >= Smokey.max_tiredness:
			Smokey.isTired = true
	else:
		Smokey.tiredness -= 2
		if Smokey.tiredness <= 0:
			Smokey.isTired = false
	return [Smokey.isTired, Smokey.hasToy]


func glyth_drawing():
	draw_box_lines()


func draw_box_lines():
	var box_pointlist = []
	var box_colors = []
	for point in Smokey.major_points:
		for point2 in go_walking(8, Smokey.minor_rotation, point[0], point[1], Smokey.major_rotation % 40):
			Smokey.major_rotation += 1
			draw_vertical_line(point2, 33)
			draw_horizontal_line(point2, 33)
	
func draw_horizontal_line(start_pos: Vector2, line_size=1) -> void:
	var end_pos = start_pos + Vector2(line_size, 0)
	draw_line(start_pos, end_pos, [Global.primary_color, Global.secondary_color].pick_random(), (line_size % 10) + 1)

func draw_vertical_line(start_pos: Vector2, line_size=1) -> void:
	var end_pos = start_pos + Vector2(0, line_size)
	draw_line(start_pos, end_pos, [Global.secondary_color, Global.thirdary_color].pick_random(), (line_size % 10) + 1)
