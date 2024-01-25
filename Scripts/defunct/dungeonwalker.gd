extends Node
class_name Walker #creates the Walker class

# WALKER CLASS

var position = Vector2.ZERO # Vector2(0,0)
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = [] # keeps track of all the steps that have been made
var steps_since_turn = 0 # counts the step since the walker started

func _init(starting_position, new_borders): # is used to construct a new Walker outside of this script
	assert(new_borders.has_point(starting_position))
	position = starting_position # sets the current position as starting position
	step_history.append(position) # adds steps to the tracker
	borders = new_borders

func walk(steps):
	for step in steps:
		if randf() <= 0.25 or steps_since_turn >= 4:
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	return false

func change_direction():
	steps_since_turn = 0
	var directions = Global.DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()
