extends "res://PetMethods/PetOwners/pet_owner.gd"


func _ready() -> void:
	super()
	scale = Vector2(.5, .5)
	owner_info = {
		"name": "Kylie",
		"age": "9",
		"location": "home",
		"occupation": "student",
	}

	favorite = {
		"flower": "",
		"color": "",
		"animal": "",
		"sport": "",
		"soda": "",
		"drink": "",
		"food": "",
		"fruit": "",
		"vegetable": ""
	}

	equipment = {
		"head": "",
		"neck": "",
		"torso": "",
		"back": "",
		"left hand": "",
		"right hand": "",
		"legs": "",
		"left foot": "",
		"right foot": ""
	}

	RSG_stuff = {
		"names": ["", "", "", "", "", "", "", "", "", ""],
		"colors": ["", "", "", "", "", "", "", "", "", ""],
		"occupations": ['', '', '', '', '', '', '', '', '', ''],
		'locations': ['', '', '', '', '', '', '', '', '', '']
	}
