extends "res://PetMethods/rock_method.gd"

enum FUR_COLOR {WHITE, BLACK, TAN, BEIGE, BROWN, GREY}
enum EYE_COLOR {BLACK, BROWN, GREEN, BLUE}
enum PHYSICAL_LOCATION {KENNEL, BED, GRASS}

var eyes
var ears
var nose
var mouth



func _ready() -> void:
	tiredness_bar.max_value = max_tiredness
	bladder_bar.max_value = max_bladder
	tummy_bar.max_value = max_tummy

func bark() -> int:
	var woof = speak(60, 100)
	return woof

func growl() -> int:
	var grrr = speak(30, 60)
	return grrr

func whine() -> int:
	var hmhm = speak(10, 30)
	return hmhm
	
func howl() -> int:
	var hoow = speak(70, 100)
	return hoow

func eats(food: String, filling: int):
	if food in ["Rice", "Apple", "Eggs"]:
		eat(true, filling)
	elif food in ["Grape", "Turd", "Bee"]:
		eat(false, filling)

func drinks(liquid: String):
	if liquid.to_lower() == "water":
		drink(true)
	else:
		drink(false)

func tug_on_rope():
	hasToy = true
	tiredness += 5
	tiredness_bar.value = tiredness
	if tiredness >= max_tiredness:
		isTired = true

func rest():
	hasToy = false
	tiredness -= 2
	tiredness_bar.value = tiredness
	if tiredness <= 0:
		isTired = false

func play(withToy=false):
	super()
