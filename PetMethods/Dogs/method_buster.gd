extends "res://PetMethods/Dogs/method_dog.gd"

var blues_fur_color = []
var blues_eye_color
var pet_owner
var available_water = 36

enum BUSTERS_LOCATIONS {PORCH, UNDERNEATH_BED}
enum AVAILABLE_ARTYLES {RECIPE, WORDIE}

var SOUP_RECIPE_DICT = {
	"Beef Shtoe": {
		"recipe_info": ["DJ Spray", "Beef Shtoe", "soup"],
		"ingredients": {
			"Potatoes": ["7"],
			"Carrots": ["5"],
			"Onions": ["2"],
			"Old Shoe": ["1"],
			"Beef": ["4lbs"],
			"Garlic cloves": ["3"]
		},
		"directions": {
			"Step 1": "Boil water.",
			"Step 2": "Add food.",
			"Step 3": "Wait 6 hours.",
			"Step 4": "Beef shtoe."
		}
	},
	"Chicken Noo-noo": {
		"recipe_info": ["DJ Spray", "Chicken Noo-noo", "soup"],
		"ingredients": {
			"Chicken": ["1"],
			"Noo": ["2"],
			"Onions": ["3"],
			"Celery": ["4"],
			"Carrots": ["5"]
		},
		"directions": {
			"Step 1": "Cook a chicken.",
			"Step 2": "Add some noo.",
			"Step 3": "Serve it hot.",
			"Step 4": "That's chicken noo-noo."
		}
	}
}

func _ready() -> void:
	pet_name = "Buster"
	blues_fur_color.append(FUR_COLOR.WHITE)
	blues_fur_color.append(FUR_COLOR.BLACK)
	blues_fur_color.append(FUR_COLOR.BROWN)
	blues_eye_color = EYE_COLOR.BROWN
	max_tiredness = 87
	max_bladder = 180
	max_tummy = 150
	isHungry = true
	isThirsty = true
	recipe_names = SOUP_RECIPE_DICT.keys()
	if get_parent() != null:
		pet_owner = get_parent()
	set_major_points(polypointlist(6, 0, 140, 140, 69))
	set_minor_points(polypointlist(3, 120, 185, 105, 42))
	super()

func bark_bark(min_x, max_x, min_y, max_y) -> Vector2:
	var woof = speak(min_x, max_x)
	var ruff = speak(min_y, max_y)
	return Vector2(woof, ruff)

func playful_bark():
	pass

func danger_bark():
	pass

func _draw() -> void:
	pass


func grooowl() -> Vector2:
	var grrr = speak(45, 80)
	var ggrr = speak(30, 45)
	print("Buster growled!")
	#pet_owner.alerted() 
	return Vector2(grrr, ggrr)
	
func whiiiine() -> Vector2:
	var hmhm = speak(10, 30)
	var hmmm = speak(10, 30)
	#print("Buster is whining!")
	#pet_owner.annoyed()
	return Vector2(hmhm, hmmm)
	
func hoowwl():
	var hoow = speak(90, 120)
	var aruu = speak(80, 100)
	print("Buster is howling!")
	#pet_owner.alerted()
	
func _process(delta: float) -> void:
	pass
	
func eats(food: String, filling: int) -> String:
	#super(food, filling)
	var fuud = ["food", "vegetable", "fruit"].pick_random()
	var eating_string = pet_owner.owner_info['name'] + " fed Buster some " + pet_owner.favorite[fuud] + "!" 
	return eating_string
	
func kicks(kicked_thing: String) -> String:
	var kick_obj = ["flower", "animal", "soda"].pick_random()
	var kicking_string = "Buster kicked the " + pet_owner.favorite[kick_obj] + "?!"
	return kicking_string
	
func drops_deuce(subject="Buster", predicate="is so good boi") -> String:
	var new_sentence = subject + " " + predicate + "!"
	return new_sentence
	
func this_be_test() -> Node2D:
	return self
	
