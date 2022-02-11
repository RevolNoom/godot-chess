extends "res://Move/Action.gd"

var _UCIName = ""
var _SANName = ""
var _actions = []


func UCI():
	return _UCIName
	
func SAN():
	return _SANName

func ActOn(Board):
	for action in _actions:
		action.ActOn(Board)
	
func Undo(Board):
	# Undo in reverse
	for i in range(_actions.size()-1, -1, -1):
		_actions[i].Undo(Board)
