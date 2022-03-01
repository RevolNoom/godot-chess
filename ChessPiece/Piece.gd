extends KinematicBody2D

class_name Piece
#Responsibilities:
#+ Tells the valid moves it can make
#+ Tells its type

export var _IsWhite = false

# OVERRIDE ME
func GetValidMoves(): 
	return []
	
# OVERRIDE ME
func Notation():
	return "?"
	
func IsSameSideWith(Piece):
	return Piece._IsWhite == _IsWhite
	
# PROTECTED:

# Get the name of the cell this piece is on
# Or null if it's dangling
func GetPosition():
	var cell = get_parent()
	if cell:
		return cell.GetName()
	return null


# Return the cell this piece is hovering on
func CellHoveredOver():
	var collideInfo = move_and_collide(Vector2(0,0.01), true, true, true)
	if collideInfo != null and collideInfo.get_collider() != null:
		return collideInfo.get_collider()
	return null


# Get the Board this piece is on
# Null if it's on nothing
func GetBoard():
	var cell = get_parent()
	if cell != null:
		var board = cell.get_parent()
		if board != null:
			return board
	return null
