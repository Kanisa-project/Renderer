extends "res://UI/scripts/tab_bar_artyle.gd"

@onready var recipe_name_lbl = $RecipeOptions/recipeName
@onready var recipe_author_lbl = $RecipeOptions/recipeAuthor
@onready var prev_btn = $RecipeOptions/recipeCycleHbox/prevBtn
@onready var next_btn = $RecipeOptions/recipeCycleHbox/nextBtn

var recipe_name_array = []
var recipe_book_array = []
var selected_recipe_name = "PBnJ"
var selected_recipe_index = 0

func _ready() -> void:
	SignalBus.recipe_next.connect(reload_recipe_info_list)
	SignalBus.recipe_prev.connect(reload_recipe_info_list)

func reload_tab_options():
	super()
	SignalBus.recipe_reload_book.emit()
	if "recipe" in Global.loaded_masterpiece:
		reload_recipe_info_list()

func reload_recipe_book() -> void:
	SignalBus.recipe_reload_book.emit()

func reload_recipe_info_list():
	if "recipe" in Global.loaded_masterpiece.keys():
		var recipe_info_array = Global.loaded_masterpiece['recipe']['recipe_info']
		recipe_name_lbl.text = recipe_info_array[1]
		recipe_author_lbl.text = recipe_info_array[0]


func _on_prev_btn_pressed() -> void:
	SignalBus.recipe_prev.emit()
	reload_recipe_info_list()


func _on_next_btn_pressed() -> void:
	SignalBus.recipe_next.emit()
	reload_recipe_info_list()


func _on_rand_btn_pressed() -> void:
	pass # Replace with function body.
