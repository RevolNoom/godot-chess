extends Node2D

# Handle pieces movement, board setup
# DO NOT generate moves, check valid move
#TODO: Auto center-align chess pieces

signal MovePlayed(SelfBoard)

var _boardState = [[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null],
					[null, null, null, null, null, null, null, null]]


# Mapping between char and piece, used for initializing pieces
var _CharToPiece = {'k': preload("res://ChessPiece/Black/KingBlack.tscn"),
					'p': preload("res://ChessPiece/Black/PawnBlack.tscn"),
					'r': preload("res://ChessPiece/Black/RookBlack.tscn"),
					'q': preload("res://ChessPiece/Black/QueenBlack.tscn"),
					'n': preload("res://ChessPiece/Black/KnightBlack.tscn"),
					'b': preload("res://ChessPiece/Black/BishopBlack.tscn"),
					
					'K': preload("res://ChessPiece/White/KingWhite.tscn"),
					'P': preload("res://ChessPiece/White/PawnWhite.tscn"),
					'R': preload("res://ChessPiece/White/RookWhite.tscn"),
					'Q': preload("res://ChessPiece/White/QueenWhite.tscn"),
					'N': preload("res://ChessPiece/White/KnightWhite.tscn"),
					'B': preload("res://ChessPiece/White/BishopWhite.tscn")}
	
# Delete all pieces on the board from memory
# From Fen string, load pieces to the board
# Does not check FEN validity. It's Judge's job
func LoadBoard(FEN):
	
	# Delete pieces
	for row in _boardState:
		for piece in row:
			if not piece == null:
				piece.queue_free()
			
	var Col = "abcdefgh"
	var colNo = 0
	var row = 8
	
	for i in FEN:
		if str(i).is_valid_integer():	# Batches of blank cells. Ignore them
			colNo += int(i)
			
		# Go down a row
		elif i == "/":	
			colNo = 0 
			row -= 1
			
		# We encounter a piece. Instance it and put it on the board
		elif i in "kprqnbKPRQNB": 
			var currentCell = Col[colNo] + str(row)
			var newPiece = _CharToPiece[i].instance()
			_boardState[row][colNo] = newPiece
			#TODO: Replace with MoveTo()
			get_node(currentCell).add_child(newPiece)
			colNo += 1 # Advance to next cell
			
		# We encountered something else
		# which is cue to leave
		else: 
			break

func GetState():
	return _boardState
	
func GetFEN():
#TODO:
	return _boardState
	

func Play(Move):
	Move.ActOn(self)
	emit_signal("MovePlayed", self)



# PROTECTED
# These functions are handles for Action objects to modify this Board

# @from, @to: cell name strings
# Move a piece from cell "from" to cell "to" 
# Assume that @from already has a Piece
# Does not check for other piece's occupation at destination
# TODO: Smoothly tween the movement?
func Mobilize(from, to):
	var indicesF = TranslateToBoardIndices(from)
	var indicesT = TranslateToBoardIndices(to)
	
	var movingPiece = _boardState[indicesF[0]][indicesF[1]]
	movingPiece.MoveTo(get_node(to))
	_boardState[indicesF[0]][indicesF[1]] = null
	_boardState[indicesT[0]][indicesT[1]] = movingPiece
	
	
# @at: Cell name string 
# Remove a chess Piece at @at from the board, and return it
# Does nothing and return null if no piece exists at @at
func Capture(at):
	var indices = TranslateToBoardIndices(at)
	var CapturedPiece = _boardState[indices[0]][indices[1]]
	if CapturedPiece != null:
		CapturedPiece.get_parent().remove_child(CapturedPiece)
		_boardState[indices[0]][indices[1]] = null
	return CapturedPiece

# @piece: A Piece object to put on the Board
# @atCell: cell name string
# Does not check for other piece's presence when update the state
# It's Judge's job
func Spawn(piece, atCell):
	piece.MoveTo(atCell)
	var indices = TranslateToBoardIndices(atCell)
	_boardState[indices[0]][indices[1]] = piece
	

# PRIVATE:

# Return an array of 2 integers: [row, column]
var _translatorDictionary = {
	'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7,
	'1': 0, '2': 1, '3': 2, '4': 3, '5': 4, '6': 5, '7': 6, '8': 7
}
func TranslateToBoardIndices(cellName):
	return [_translatorDictionary[cellName[0]], _translatorDictionary[cellName[1]]]
