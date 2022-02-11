extends "res://Move/Action.gd"

var _piece
var _atCell

# @spawnPiece: a Piece object
# @atCell: cell name string ("a1", "h8")
func _init(spawnPiece, atCell):
	_piece = spawnPiece
	_atCell = atCell
	
func ActOn(Board):
	Board.Spawn(_piece, _atCell)
	
func Undo(Board):
	var returnPiece = Board.Capture(_atCell)
	if _piece != returnPiece:
		printerr("Spawn object gets back different piece!")
