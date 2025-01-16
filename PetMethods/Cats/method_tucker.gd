extends "res://PetMethods/Cats/method_cat.gd"

var LEFT = Vector2(-1, 0)
var RIGHT = Vector2(1, 0)
var UP = Vector2(0, -1)
var DOWN = Vector2(0, 1)

func lay_left(cell_pos: Vector2) -> Vector2:
	cell_pos += LEFT
	return cell_pos

func lay_right(cell_pos: Vector2) -> Vector2:
	cell_pos += RIGHT
	return cell_pos

func look_up(cell_pos: Vector2) -> Vector2:
	cell_pos += UP
	return cell_pos
	
