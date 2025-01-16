extends "res://PetMethods/Dogs/method_dog.gd"

var beamys_fur_color = []
var beamys_eye_color
var pet_owner


enum BEAMYS_LOCATIONS {GRASS, LAP}

var SANDWICH_RECIPE_DICT = {
	'Jalaturkeypeno': {
		"recipe_info": ["DJ Spray", 'Jalaturkeypeno', 'sandwich'],
		"ingredients": {
			"Turkey": ["3 slices"],
			"Cream Cheese": ["1T"],
			"Mayonnaise": ["⚝"],
			"Mustard": ["⚝"],
			"Provolone Cheese": ["1 slice"],
			"Cheddar Jalapeno Bagel": ["two halves"]

		},
		"directions": {
			"Step 1": "Toast the bagel then spread your condiments on.",
			"Step 2": "Add the provolone cheese and turkey.",
			"Step 3": "Sandwich together and enjoy.",
		}
	},
	'PBJ': {
		"recipe_info": ["DJ Spray", 'PBJ', "sandwich"],
		"ingredients": {
			"Peanut butter": ["2TBSP"],
			"Grape jelly": ["2TBSP"],
			"Bread": ["2 slices"]

		},
		"directions": {
			"Step 1": "Spread peanut butter on one slice of bread.",
			"Step 2": "Spread jelly on other slice of bread.",
			"Step 3": "Sandwich together and enjoy.",
		}
	}
}

func _ready() -> void:
	pet_name = "Beamy"
	beamys_fur_color.append(FUR_COLOR.BROWN)
	beamys_fur_color.append(FUR_COLOR.WHITE)
	beamys_eye_color = EYE_COLOR.BROWN
	max_tiredness = 187
	max_bladder = 120
	max_tummy = 150
	recipe_names = SANDWICH_RECIPE_DICT.keys()
	super()

func bark_bark() -> Vector2:
	var woof = speak(60, 90)
	var ruff = speak(60, 90)
	print("Beamy barked! ", woof)
	pet_owner.alerted()
	return Vector2(woof, ruff)

func grooowl() -> Vector2:
	var grrr = speak(30, 45)
	var ggrr = speak(30, 45)
	print("Beamy growled!")
	pet_owner.alerted()
	return Vector2(grrr, ggrr)

func whiiiine() -> Vector2:
	var hmhm = speak(40, 65)
	var hmmm = speak(40, 65)
	#print("Beamy is whining!")
	#pet_owner.annoyed()
	return Vector2(hmhm, hmmm)

func howl():
	var hoow = super()
	var aruu = speak(80, 100)
	print("Beamy is howling!")
	pet_owner.alerted()

func eats(food: String, filling: int):
	super(food, filling)
	print("Beamy ate some ", food, "! ", tummy)
