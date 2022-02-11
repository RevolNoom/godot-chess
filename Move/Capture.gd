extends "res://Move/Action.gd"

var _atCell = ""
var _capturedPiece = null

# @at: cell name strings
func _init(at):
	_atCell = at
	
func ActOn(Board):
	_capturedPiece = Board.Capture(_atCell)
	
func Undo(Board):
	Board.Spawn(_capturedPiece, _atCell)
