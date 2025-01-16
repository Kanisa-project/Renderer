extends NinePatchRect

@onready var tick_timer = $tickTimer
@onready var tock_timer = $tockTimer

var active_gaym := "None"

var gridded_points = []
var rng = RandomNumberGenerator.new()



func _ready() -> void:
	rng.randomize()
	#SignalBus.gaym_changed.connect(switch_gaym.bind("TED"))
	SignalBus.masterpiece_update_tick.connect(update_tick_speed)
	SignalBus.masterpiece_update_tock.connect(update_tock_speed)
	gridded_points = set_gridded_points(5, 5)
	
func update_tick_speed(val_chang: bool, new_speed: int):
	tick_timer.wait_time = new_speed
	#print("9P i_updated ", new_speed) 
	
func update_tock_speed(val_chang: bool, new_speed: float):
	tock_timer.wait_time = new_speed
	#print("9P o_updated ", new_speed) 
	
	
func set_gridded_points(w_slots: int, h_slots: int) -> Array:
	var grid_points = []
	for w in range(0, size.y, size.y/w_slots):
	#for w in range(0, size.x, size.x/w_slots):
		grid_points.append([])
		for h in range(0, size.y, size.y/h_slots):
			grid_points[grid_points.size()-1].append(Vector2(w, h))
	return grid_points
	
func switch_gaym(new_gaym: String) -> void:
	active_gaym = new_gaym
	print("ACTIVE:  ", active_gaym)
