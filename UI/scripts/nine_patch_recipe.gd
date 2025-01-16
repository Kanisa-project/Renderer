extends "res://UI/scripts/nine_patch_artyle.gd"

@onready var ingredients_text = $IngredInfoHbox/IngredientsRichText
@onready var information_text = $IngredInfoHbox/InformationRichText
@onready var directions_text = $DirectionsRichText

@onready var Bethany = $OwnerBethany

var recipe_book_index = 0
var recipe_book_names = ["test"]
var recipe_book_dict = {}
var chosen_recipe_dict = {}

func _ready() -> void:
	SignalBus.recipe_prev.connect(prev_recipe)
	SignalBus.recipe_next.connect(next_recipe)
	SignalBus.recipe_reload_book.connect(reload_recipe_book_dict)
	reload_recipe_book_dict()
	Bethany.position = Vector2(-360, 250)
	
func reload_recipe_book_names():
	recipe_book_names = []
	for recipe_name in Bethany.Smokey.SEASONING_RECIPE_DICT.keys():
		recipe_book_names.append(recipe_name)
	for recipe_name in Bethany.Beamy.SANDWICH_RECIPE_DICT.keys():
		recipe_book_names.append(recipe_name)
	#for recipe_name in Bethany.Buster.SOUP_RECIPE_DICT.keys():
		#recipe_book_names.append(recipe_name)
	if "recipe" in Global.loaded_masterpiece:
		recipe_book_names.append(Global.loaded_masterpiece['recipe']['recipe_info'][1])

func reload_recipe_book_dict():
	reload_recipe_book_names()
	recipe_book_dict = Bethany.recipe_book
	if "recipe" in Global.loaded_masterpiece:
		recipe_book_dict[Global.loaded_masterpiece['recipe']['recipe_info'][1]] = Global.loaded_masterpiece['recipe']
	
func reload_ingredient_list(ingred_dict: Dictionary):
	ingredients_text.modulate = Global.primary_color
	ingredients_text.text = "Ingredients: \n"
	for ingred in ingred_dict.keys():
		ingredients_text.text += ingred + ": " + ingred_dict[ingred][0] + "\n"

func reload_direction_list(direct_dict: Dictionary):
	directions_text.modulate = Global.secondary_color
	directions_text.text = "Directions: \n"
	for direct in direct_dict.keys():
		directions_text.text += direct + ": " + direct_dict[direct] + "\n"
		
func reload_recipe_info_list(recipe_info_array: Array):
	information_text.modulate = Global.thirdary_color
	information_text.text = "[right]Recipe Name: " + recipe_info_array[1] + "\n[/right]"
	information_text.text += "Created by: " + recipe_info_array[0] + "\n"
	
func prev_recipe():
	recipe_book_index = clamp_recipe_book_index(-1)
	chosen_recipe_dict = recipe_book_dict[recipe_book_names[recipe_book_index]]
	reload_ingredient_list(chosen_recipe_dict["ingredients"])
	reload_direction_list(chosen_recipe_dict["directions"])
	reload_recipe_info_list(chosen_recipe_dict["recipe_info"])

func next_recipe():
	recipe_book_index = clamp_recipe_book_index()
	chosen_recipe_dict = recipe_book_dict[recipe_book_names[recipe_book_index]]
	print(chosen_recipe_dict)
	reload_ingredient_list(chosen_recipe_dict["ingredients"])
	reload_direction_list(chosen_recipe_dict["directions"])
	reload_recipe_info_list(chosen_recipe_dict["recipe_info"])

func clamp_recipe_book_index(next_index=1) -> int:
	recipe_book_index += next_index
	if recipe_book_index >= recipe_book_names.size():
		recipe_book_index = 0
	elif recipe_book_index < 0:
		recipe_book_index = recipe_book_names.size() - 1
	return recipe_book_index
