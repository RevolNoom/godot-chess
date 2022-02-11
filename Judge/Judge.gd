extends Node

# Handle chess logic
# Derive new Judge type for new chess rule
# E.g. Chess960, King of the hill, ...

var _WhitePlayer
var _BlackPlayer

# OVERRIDE THESE:
func _ready():
	pass 

func PlayMove(UCI):
	pass
	
func Status():
	pass
	
func GetLegalMoves():
	pass
	
# DEFAULT HELPER FUNCTIONS
# Override them if you need something fancier

func SetPlayer(WhitePlayer, BlackPlayer):
	pass

func SetBoard(Board):
	pass
	
func GetFEN():
	pass
	
func PromptMove():
	pass
	
func Undo():
	pass
