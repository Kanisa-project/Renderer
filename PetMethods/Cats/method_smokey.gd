extends "res://PetMethods/Cats/method_cat.gd"

var smokeys_fur_color = [FUR_COLOR.TAN, FUR_COLOR.GREY]
var smokeys_eye_color = EYE_COLOR.YELLOW
var pet_owner

enum SMOKEYS_LOCATIONS {WINDOWSILL, COUCH_BACK}

var SEASONING_RECIPE_DICT = {}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	tummy -= .2
	if tummy <= 5:
		isHungry = true
	tummy_bar.value = tummy

func meeoow() -> Vector2:
	var miiow = speak(30, 70)
	var mioow = speak(30, 70)
	return Vector2(miiow, mioow)
