extends Action
class_name Spawn

var _piece
var _atCell

# @spawnPiece: a Piece object
# @atCell: cell name string ("a1", "h8")
func _init(spawnPiece, atCell):
	_piece = spawnPiece
	_atCell = atCell
	
func ActOn(board):
	var bi = board.Iterator()
	bi.GoTo(_atCell)
	bi.Add(_piece)
	
func Undo(board):
	var bi = board.Iterator()
	bi.GoTo(_atCell)
	_piece = bi.Remove()
