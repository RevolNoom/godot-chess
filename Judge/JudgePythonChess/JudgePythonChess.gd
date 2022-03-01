extends Judge
class_name JudgePythonChess

	
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
