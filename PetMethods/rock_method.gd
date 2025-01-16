extends Node2D

@onready var tiredness_bar = $tirednessBar
@onready var bladder_bar = $bladderBar
@onready var tummy_bar = $tummyBar

var major_points:= []
var minor_points:= []
var major_rotation := 0
var minor_rotation := 0
var major_numbers := 3
var minor_numbers := 9

var colora

var pet_method_name = "base"
var isTired := false
var isHungry := false
var isThirsty := false
var canPee := false
var canPoop := false
var hasToy := false

enum POSSIBLE_AILMENTS {TUMMY_ACHE, BLIND, DEAF, ITCHY}
var afflictions_array := []

var pet_name := "Rocko"

var max_tiredness := 100
var tiredness := 10
var max_bladder := 100
var bladder := 10
var max_tummy := 100
var tummy := 10

var rng = RandomNumberGenerator.new()

var recipe_names := []

func _ready():
	rng.randomize()

func _process(delta):
	pass

func polypointlist(sides: int, offset: int, cx: int, cy: int, radius: int) -> Array:
	"""This is a desc."""
	var step = 2 * PI / sides
	var ophset = deg_to_rad(offset)
	var pointlist = []
	for n in range(0, int(sides) + 1):
		pointlist.append(Vector2(radius * cos(step * n + ophset) + cx, radius * sin(step * n + ophset) + cy))
	return pointlist

func set_minor_points(new_minors: Array):
	minor_points = new_minors

func set_major_points(new_majors: Array):
	major_points = new_majors

func action() -> int:
	play(true)
	tiredness += 4
	return tiredness

func speak(min_volume: int, max_volume: int) -> float:
	return rng.randi_range(min_volume, max_volume)

func is_sleeping() -> bool:
	#eyes.closed()
	if isTired:
		tiredness -= 4
		if tiredness <= 0:
			return false
	return true

func play(withToy=false):
	if tiredness <= max_tiredness and !isTired:
		tiredness += 6
		hasToy = withToy
		if withToy:
			tiredness += 6
	else:
		isTired = true

func rest():
	if tiredness <= 0:
		isTired = false
	else:
		tiredness -= 1
		if isTired:
			is_sleeping()

func eat(isEdible: bool, filling: int):
	if tummy <= max_tummy and isHungry:
		if isEdible:
			tummy += filling
		elif !isEdible:
			tummy += filling
			afflictions_array.append(POSSIBLE_AILMENTS.TUMMY_ACHE)
	else:
		isHungry = false
		canPoop = true
	tummy_bar.value = tummy

func drink(isWater: bool):
	if bladder <= max_bladder and isThirsty:
		if isWater:
			bladder += 5
		elif !isWater:
			afflictions_array.append(POSSIBLE_AILMENTS.TUMMY_ACHE)
			bladder += 5
	else:
		isThirsty = false
		canPee = true
	bladder_bar.value = bladder

func potty():
	if canPee:
		tinkle()
		bladder_bar.value = bladder
	if canPoop:
		deuces()
		tummy_bar.value = tummy

func tinkle():
	if bladder >= max_bladder:
		bladder -= int(max_bladder / 2)
		isThirsty = true
	canPee = false

func deuces():
	if tummy >= max_tummy:
		tummy -= int(max_tummy / 2)
		isHungry = true
	canPoop = false
