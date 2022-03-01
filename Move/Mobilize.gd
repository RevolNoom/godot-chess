extends Action
class_name Mobilize

# Move a piece from _from to _to
# Does not check for pieces-same-cell collision
# It's assumed that _from has a piece, and _to is vacant

var _from = ""
var _to = ""

# @from, @to: cell name strings
func _init(from, to):
	_from = from
	_to = to
	
func ActOn(board):
	var bi = board.Iterator()
	bi.GoTo(_from)
	var piece = bi.Remove()
	bi.GoTo(_to)
	bi.Add(piece)
	
func Undo(board):
	var bi = board.Iterator()
	bi.GoTo(_to)
	var piece = bi.Remove()
	bi.GoTo(_from)
	bi.Add(piece)
