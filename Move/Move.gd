extends Action
class_name Move

var _UCIName = ""
var _SANName = ""
var _actions = []


func UCI():
	return _UCIName
	
func SAN():
	return _SANName

func ActOn(board):
	for action in _actions:
		action.ActOn(board)
	
func Undo(Board):
	# Undo in reverse
	for i in range(_actions.size()-1, -1, -1):
		_actions[i].Undo(board)
