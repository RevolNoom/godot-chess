# PLAYER INTERFACE
# Defines how a player (Human or engine or alien or zombie or vampire or...)
# will make their move
extends Node
class_name Player

# warning-ignore:unused_signal
signal MoveConstructed(UCIMove)
# warning-ignore:unused_signal
signal AskRetryMove()

# OVERRIDE ME!
func HandleMoveRequest(_Board):
	pass
