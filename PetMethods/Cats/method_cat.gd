extends "res://PetMethods/rock_method.gd"

enum FUR_COLOR {WHITE, BLACK, TAN, BEIGE, BROWN, GREY, ORANGE}
enum EYE_COLOR {BLACK, BROWN, GREEN, BLUE, YELLOW}
enum PHYSICAL_LOCATION {BASKET, BED, COUCH, GRASS}

func meow() -> int:
	var moww = speak(0, 9)
	return moww

func purr() -> int:
	var prrr = speak(10, 30)
	return prrr

func hiss() -> int:
	var hsss = speak(50, 90)
	return hsss

func yowl() -> int:
	var yoww = speak(70, 100)
	return yoww
