extends "res://Move/Action.gd"

var _from = ""
var _to = ""

# @from, @to: cell name strings
func _init(from, to):
	_from = from
	_to = to
	
func ActOn(Board):
	Board.Mobilize(_from, _to)
	
func Undo(Board):
	Board.Mobilize(_to, _from)
