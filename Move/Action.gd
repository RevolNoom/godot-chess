# Base Interface for any objects that can modify a chess board
# VISITOR PATTERN
extends Node

# OVERRIDE ME
func ActOn(Board): 
	pass

# OVERRIDE ME	
func Undo(Board):
	pass
