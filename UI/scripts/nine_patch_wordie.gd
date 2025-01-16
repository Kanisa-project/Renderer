extends "res://UI/scripts/nine_patch_artyle.gd"

'''
https://webapps.towson.edu/ows/SentPatt.aspx
MAJOR SHOUT OUT TO THIS SITE AND WEB PAGE SPECIFICALLY! ;D
'''

@onready var Susan = $OwnerSusan
@onready var Justin = $OwnerJustin
@onready var Jacob = $OwnerJacob
@onready var sentence_slot_one = $RSG_slots/SlotOne
@onready var sentence_slot_two = $RSG_slots/SlotTwo
@onready var sentence_slot_three = $RSG_slots/SlotThree

var rand_numb = 0

var font_size = 12
var verbs_dict = {
		"being": ['is', 'are', 'was', 'were', 'has been', "have been", 'had been'],
		"linking": ['smell around', 'look at', 'taste like', 'feel', 'seem like', 'appear in', 'become', 'grow'],
		"action": ["caught", "kicked", "sat on", "rolled", 'carried', 'slept on', 'bought', 'robbed', 'tackled', 'rebuilt']
}

var noun_dict = {
	'delightful_names': ['Toby', 'Keith', 'Robert', 'Jim', 'Brian', 'Kelsey', 'Kayla', 'Mary', 'Ann', 'Donna'],
	'beautiful_colors': ['red', 'green', 'blue', 'black', 'white', 'purple', 'orange', 'gray', 'blood red', 'snow white'],
	'real_occupations': ['plumber', 'electrician', 'teacher', 'librarian', 'dentist', 'dishwasher', 'mechanic', 'jeweler', 'translator', 'judge'],
	'common_locations': ['bank', 'school', 'hospital', 'house', 'cafe', 'store', 'playground', 'gas station', 'library', 'mall'],
	'physical_objects': ['book', 'skateboard', 'football', 'computer', 'coffee mug', 'toy soldier', 'car', 'desk', 'marker', 'cellphone'],
	'reallygood_ideas': ['conquest', 'democracy', 'communism', 'friendship', 'transaction', 'ownership', 'baking', 'vacation', 'photography', 'competition'],
	'delicious_drinks': ['coffee', 'gatorade', 'lemonade', 'whiskey', 'root beer', 'orange fanta', 'grape soda', 'water', 'chocolate milk', 'dishpit juice'],
	'scrumptious_food': ['cheesecake', 'apple', 'lemon', 'bread', 'churro', 'avocado', 'potato', 'potato chip', 'chocolate', 'dishpit salad']
}

#var verbs_of_being = ['is', 'are', 'was', 'were', 'has been', "have been", 'had been']
#var linking_verbs = ['smell around', 'look at', 'taste like', 'feel', 'seem like', 'appear', 'become', 'grow']


var adverbs = ["lazily", "lightly", "quickly", "stupidly"]

var prepositions = ["about", "like", "within", "near", "among", "along", "to"]
var noun_signals = ["a", "the", "that", "this", "those"]
var prepositional_objects = ["crowd", "jumper", "skateboarder", "lights", "tree"]



func _ready() -> void:
	super()
	Susan.position = Vector2(-360, 250)
	Justin.position = Vector2(-360, 350)
	Jacob.position = Vector2(-240, 250)
	
func _on_tick_timer_timeout() -> void:
	rand_numb = randi_range(0, 9)
	font_size = Global.loaded_masterpiece["number_list"][9] * 3
	
	sentence_slot_one.text = sentence_pattern_six(Justin.RSG_stuff['names'].pick_random(), Justin.RSG_stuff['drinks'].pick_random(),
													Justin.RSG_stuff['locations'].pick_random(), Justin.RSG_stuff['occupations'].pick_random())
	sentence_slot_two.text = sentence_pattern_five(Justin.RSG_stuff['names'].pick_random(), Susan.RSG_stuff['names'].pick_random(),
													Justin.RSG_stuff['objects'].pick_random(), Justin.RSG_stuff['locations'].pick_random())
	sentence_slot_three.text = sentence_pattern_one(Susan.RSG_stuff['names'].pick_random(), Susan.RSG_stuff['locations'].pick_random())
	queue_redraw()
	
	
func _on_tock_timer_timeout() -> void:
	sentence_slot_one.modulate = Global.primary_color
	sentence_slot_two.modulate = Global.secondary_color
	sentence_slot_three.modulate = Global.thirdary_color

#func update_reading_time(new_time: int) -> void:
	#$tickTimer.wait_time = new_time
	
func sentence_pattern_one(name1: String, idea: String) -> String:
	var new_sentence = name1 + " "
	new_sentence += adverbs.pick_random() + " "
	new_sentence += verbs_dict['action'].pick_random() + " "
	new_sentence += noun_phraser(idea)
	return new_sentence + "!"
	
func sentence_pattern_two() -> String:
	var new_sentence = "Did " + noun_phraser(noun_dict["real_occupations"].pick_random()) + " "
	new_sentence += verbs_dict['linking'].pick_random() + " "
	new_sentence += noun_phraser(noun_dict['reallygood_ideas'].pick_random())
	#new_sentence += noun_phraser(noun_dict['reallygood_ideas'][5])
	return new_sentence + "?"
	
func sentence_pattern_three() -> String:
	var new_sentence = Susan.RSG_stuff["names"].pick_random() + ", "
	new_sentence += "the " + noun_dict['real_occupations'].pick_random() + ", "
	new_sentence += verbs_dict['action'].pick_random() + " " + noun_phraser(noun_dict['physical_objects'].pick_random()) + " and went to "
	new_sentence += "the " + noun_dict['common_locations'].pick_random() 
	return new_sentence + "."
	
func sentence_pattern_four() -> String:
	var new_sentence = Susan.RSG_stuff["names"].pick_random() + " "
	new_sentence += verbs_dict['action'].pick_random() + " " + noun_phraser(noun_dict['physical_objects'].pick_random()) + " and "
	new_sentence += verbs_dict['action'].pick_random() + " " + noun_phraser(noun_dict['physical_objects'].pick_random())
	return new_sentence + "!"
	
func sentence_pattern_five(name1: String, name2: String, phys_obj: String, comm_loc: String) -> String:
	var new_sentence = name2 + " and " + name1 + " "
	new_sentence += verbs_dict['action'].pick_random() + " " + noun_phraser(phys_obj) + " after they "
	new_sentence += verbs_dict['action'].pick_random() + " " + noun_phraser(comm_loc)
	return new_sentence + "!"
	
func sentence_pattern_six(name1: String, drink: String, comm_loc: String, occupation: String) -> String:
	var new_sentence = "After " + name1 + " chugged a gallon of " + drink + ""
	new_sentence += " he robbed " + noun_phraser(comm_loc) + ", but on his way out"
	new_sentence += " was " + verbs_dict['action'].pick_random() + " by " + noun_phraser(occupation)
	return new_sentence + "!"

func noun_phraser(noun="desk") -> String:
	var noun_signal = noun_signals.pick_random()
	if noun_signal == "a" and noun[0].to_lower() in ['a', 'e', 'i', 'o', 'u']:
		noun_signal += 'n'
	var noun_phrase = noun_signal + " "
	noun_phrase += noun
	if noun_signal == "those":
		noun_phrase += "s"
		if noun.ends_with('o'):
			noun_phrase[-1] = "es"
		elif noun.ends_with('y'):
			noun_phrase[-1] = "ies"
	return noun_phrase
	
func prepositional_phraser() -> String:
	var new_phrase = ""
	new_phrase += prepositions.pick_random() + " "
	new_phrase += noun_signals.pick_random() + " "
	new_phrase += prepositional_objects.pick_random()
	return new_phrase

func dependent_clauser() -> String:
	var new_clause = ''
	return new_clause

func independent_clauser(subject="Tom", verb='reads', noun="book") -> String:
	var new_clause = subject + " "
	new_clause += verb + " "
	new_clause += noun_phraser(noun) + "." 
	return new_clause

func simple_sentence() -> String:
	var the_sentence = independent_clauser()
	return the_sentence
