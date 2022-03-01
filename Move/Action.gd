# Base Interface for any objects that can modify a chess board
# VISITOR PATTERN
extends Reference

class_name Action

# OVERRIDE ME
func ActOn(_board): 
	pass

# OVERRIDE ME	
func Undo(_board):
	pass
