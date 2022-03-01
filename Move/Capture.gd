extends Action
class_name Capture

var _atCell = ""
var _capturedPiece = null


# @at: cell name strings
func _init(at):
	_atCell = at
	
func ActOn(board):
	var bi = board.Iterator()
	bi.GoTo(_atCell)
	_capturedPiece = bi.Remove()
	
	
func Undo(board):
	var bi = board.Iterator()
	bi.GoTo(_atCell)
	bi.Add(_capturedPiece)
