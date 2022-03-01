extends Node
class_name Judge

# Handle chess logic
# Derive new Judge type for new chess rule
# E.g. Chess960, King of the hill, ...

# _Player = [black, white]
var _Player = [null, null]
var _WhiteTurn = true
var _Board

# OVERRIDE THESE:
func _ready():
	pass 

func PlayMove(_UCI):
	pass

# Unknown: "-"
# White wins: "1-0"
# Black wins: "0-1"
# Draw: "1/2-1/2"	
func Status():
	return "-"
	
	
func GetLegalMoves():
	pass
	
# The starting FEN of this game mode
# Standard FEN for standard chess. 
# Random FEN for Fischer chess (chess960)
func GetStartingFEN() -> String:
	return ""
	
	
func StartGame():
	print("Game Started")
	_Board.LoadBoard(GetStartingFEN())
	ContinueTheGame()

func ContinueTheGame():
	if Status() == "-":
		PromptMove()
	else:
		print(Status())
	
	
# DEFAULT HELPER FUNCTIONS
# Override them if you need something fancier

func SetPlayer(whitePlayer, blackPlayer):
	# DON'T MESS UP THE COLOR ORDER
	var player = [blackPlayer, whitePlayer]
	for i in range(0, 2):
		if _Player[i] != null:
			_Player[i].disconnect("AskRetryMove", self, "PromptMove")
			_Player[i].disconnect("MoveConstructed", self, "Play")
			
		_Player[i] = player[i]
		_Player[i].connect("AskRetryMove", self, "PromptMove")
		_Player[i].connect("MoveConstructed", self, "Play")
		
func SetBoard(board):
	_Board = board
	
	
func GetFEN():
	pass
	
	
func PromptMove():
	_Board.RealignPieces()
	print("Prompting Move")
	print("Legal Moves: " + str(GetLegalMoves()))
	_Player[int(_WhiteTurn)].HandleMoveRequest(_Board)
		
		
func Undo():
	pass
