extends "res://UI/scripts/nine_patch_artyle.gd"

@onready var shader_material = material as ShaderMaterial
@onready var Susan = $OwnerSusan
@onready var Jacob = $OwnerJacob
@onready var Robert = $OwnerRobert

var gridded_glyph = []
var grid_size = 16
var cell_size = 640
var main_cell := Vector2.ZERO
var active_glyphs = []
var snake_body = []
var snake_dir = Vector2.RIGHT

func _ready() -> void:
	gridded_glyph = set_gridded_points(grid_size, grid_size)
	cell_size = int(size.y/grid_size)
	SignalBus.glyph_change_active.connect(collect_active_glyphs)
	Jacob.position = Vector2(-360, 250)
	Susan.position = Vector2(-240, 250)
	Robert.position = Vector2(-360, 350)
	for i in range(8):
		snake_body.append(Vector2(-i, 0))
	
func collect_active_glyphs(available_glyphs: Array) -> void:
	active_glyphs = []
	for avail_glyph in available_glyphs:
		active_glyphs.append(avail_glyph)
	
func _draw() -> void:
	draw_grid_lines()
	for active_glyph in active_glyphs:
		match active_glyph:
			"Square":
				color_grid_cell(Jacob.primary_cell_pos)
				color_grid_cell(Jacob.primary_cell_pos + Vector2(0, 1))
				color_grid_cell(Jacob.primary_cell_pos + Vector2(1, 0))
				color_grid_cell(Jacob.primary_cell_pos + Vector2(1, 1))
			#"SlantDown":
				#color_grid_cell(Susan.primary_cell_pos)
				#slant_down(-1)
			#"SlantUp":
				#color_grid_cell(Susan.primary_cell_pos)
				#slant_up(1)
			#"Snow":
				#move_snake(snake_dir)
				#for i in range(snake_body.size() - 1):
					#color_grid_cell(snake_body[i])

func move_snake(direction: Vector2):
	var head_position = snake_body[0]
	#var new_head_position = contain_to_grid(head_position, direction)
	var new_head_position = teleport_through_grid(head_position, direction)
	snake_body.insert(0, new_head_position)
	snake_body.remove_at(snake_body.size() - 1)
	
func slant_down(x_dir=1):
	Susan.primary_cell_pos = contain_to_grid(Susan.primary_cell_pos, Vector2(x_dir, 1))
	if Susan.primary_cell_pos.x >= grid_size:
		Susan.primary_cell_pos.x = 0
	if Susan.primary_cell_pos.x <= 0:
		Susan.primary_cell_pos.x = grid_size
	if Susan.primary_cell_pos.y >= grid_size:
		Susan.primary_cell_pos.y = 0

func slant_up(x_dir=1):
	Susan.primary_cell_pos = contain_to_grid(Susan.primary_cell_pos, Vector2(x_dir, -1))
	if Susan.primary_cell_pos.x >= grid_size:
		Susan.primary_cell_pos.x = 0
	if Susan.primary_cell_pos.x <= 0:
		Susan.primary_cell_pos.x = grid_size
	if Susan.primary_cell_pos.y <= 0:
		Susan.primary_cell_pos.y = grid_size

func draw_grid_lines():
	for w in range(gridded_glyph.size()):
		for h in range(gridded_glyph[w].size()):
			draw_line(Vector2(0, cell_size*grid_size), Vector2(cell_size*grid_size, cell_size*grid_size), Global.secondary_color, 3)
			draw_line(Vector2(cell_size*grid_size, 0), Vector2(cell_size*grid_size, cell_size*grid_size), Global.secondary_color, 3)
			draw_line(gridded_glyph[w][0], gridded_glyph[w][gridded_glyph.size()-1] + Vector2(0, cell_size), Global.primary_color, 3)
			draw_line(gridded_glyph[0][h], gridded_glyph[gridded_glyph.size()-1][h] + Vector2(cell_size, 0), Global.primary_color, 3)

func _process(delta: float) -> void:
	#shader_material.set_shader_parameter("circle_size", get_global_mouse_position().x/1152)
	#shader_material.set_shader_parameter("slider_progress", get_global_mouse_position().y/648)
	pass

func color_grid_cell(cell_pos: Vector2) -> void:
	var cell_string = str(cell_pos.x) + ", " + str(cell_pos.y)
	var str_pos = Vector2(cell_pos.x * cell_size, cell_pos.y * (cell_size/2))
	var cell_points = [
		Vector2(0, 0) + (cell_pos * cell_size),
		Vector2(0, cell_size) + (cell_pos * cell_size),
		Vector2(cell_size, cell_size) + (cell_pos * cell_size),
		Vector2(cell_size, 0) + (cell_pos * cell_size)]
	draw_polygon(cell_points, [Global.primary_color, Global.primary_color, Global.thirdary_color, Global.secondary_color])
	#draw_string(get_theme_default_font(), cell_pos * cell_size, cell_string, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Global.thirdary_color)

func contain_to_grid(cell_pos: Vector2, direction: Vector2) -> Vector2:
	if cell_pos.x + direction.x <= 0:
		direction.x = 0
		direction.y = 1
	elif cell_pos.x + direction.x >= grid_size-1:
		direction.x = 0
		direction.y = -1
	elif cell_pos.y + direction.y <= 0:
		direction.x = 1
		direction.y = 0
	elif cell_pos.y + direction.y >= grid_size-1:
		direction.x = -1
		direction.y = 0
	return cell_pos + direction

func teleport_through_grid(cell_pos: Vector2, direction: Vector2) -> Vector2:
	if cell_pos.x + direction.x < 0:
		cell_pos.x = grid_size
		#direction.y = 1
	elif cell_pos.x + direction.x > gridded_glyph.size()-1:
		cell_pos.x = 0
		#direction.y = -1
	elif cell_pos.y + direction.y < 0:
		#direction.x = 1
		cell_pos.y = grid_size
	elif cell_pos.y + direction.y > gridded_glyph.size()-1:
		#direction.x = -1
		cell_pos.y = 0
	return cell_pos + direction

func _on_tick_timer_timeout() -> void:
	#Robert.primary_cell_pos = contain_to_grid(Robert.primary_cell_pos, Robert.pick_random_direction())
	#Susan.secondary_cell_pos = contain_to_grid(Susan.secondary_cell_pos, Susan.vertical_direction())
	#Susan.primary_cell_pos = contain_to_grid(Susan.primary_cell_pos, Susan.pick_random_direction())
	#snake_dir = Susan.pick_snake_direction(snake_dir)
	queue_redraw()

func _on_tock_timer_timeout() -> void:
	for active_glyph in active_glyphs:
		match active_glyph:
			"Square":
				Jacob.primary_cell_pos = contain_to_grid(Jacob.primary_cell_pos, Jacob.vertical_direction(1))
				Jacob.position = Jacob.primary_cell_pos * cell_size
			"SlantDown":
				#color_grid_cell(Susan.primary_cell_pos)
				#slant_down(-1)
				pass
			"SlantUp":
				#color_grid_cell(Susan.primary_cell_pos)
				#slant_up(1)
				pass
			"Snow":
				#move_snake(snake_dir)
				#for i in range(snake_body.size() - 1):
					#color_grid_cell(snake_body[i])
					pass
	queue_redraw()
	#print("Tock.")

#func _draw() -> void:
	##Jacob.queue_redraw()
	#pass
