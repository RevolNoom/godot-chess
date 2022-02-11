extends KinematicBody2D
#Responsibilities:
#+ Tells the valid moves it can make
#+ Tells its type

const WHITE = true
const BLACK = false
export var _color = false

# OVERRIDE ME
func GetValidMoves(): 
	pass
	
# OVERRIDE ME
func Notation():
	pass
	
func IsSameSideWith(Piece):
	return Piece._color == _color
	
# Detach from parent cell
# Attach to new Cell as child
func MoveTo(AnotherCell):
	if get_parent() != null:
		get_parent().remove_child(self)
	AnotherCell.add_child(self)
