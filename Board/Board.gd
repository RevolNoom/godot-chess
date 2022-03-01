extends Node2D

class_name Board
# Handle pieces movement, board setup
# DO NOT generate moves, check valid move
#TODO: Auto center-align chess pieces

signal MovePlayed(SelfBoard)

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
	var it = self.Iterable()
	while it.HasMore():
		var piece = it.GetNext()
		Remove(piece)
		it.queue_free()
			
	it = self.Iterator()
	it.GoTo("a8")
	
	for i in FEN:
		if str(i).is_valid_integer():	# Batches of blank cells. Ignore them
			it.Travel(int(i), 0)
			
		# Go down a row
		elif i == "/":
			it.Travel(-8, -1)
			
		# We encounter a piece. Instance it and put it on the board
		elif i in "kprqnbKPRQNB":
			var newPiece = _CharToPiece[i].instance()
			it.Add(newPiece)
			it.Travel(1, 0)
			
		# We encountered something else
		# which is cue to leave
		else: 
			break


func Iterator():
	return IteratorRA.new(self)
	
	
func Iterable():
	return Iterable.new(self)
	
	
# Align all pieces on the board to the center of their squares
func RealignPieces():
	var it = Iterable()
	while it.HasMore():
		RealignPiece(it.GetNext())
		

# Align a piece to the center of its square
func RealignPiece(piece):
	piece.set_position(0, 0)
	
# PROTECTED:

# FOR ITERATOR
# Add a Piece to cell @pos
func Add(piece, pos):
	get_node(pos).add_child(piece)
	
	
# FOR ITERATOR
# Return and remove the Piece at @pos off the board
func Remove(pos) -> Piece:
	var piece = get_node(pos)
	# Detach from parent
	if piece != null:
		piece.get_parent().remove_child(piece)
	return piece
	

# FOR ITERATOR
# Move a piece from @cellFrom to @cellTo
# TODO: Tween animation please?
func Mobilize(cellFrom, cellTo):
	var piece = Remove(cellFrom)
	Add(piece, cellTo)
	RealignPiece(piece)
	
	
func GetFEN():
	#var bi = Iterator()
	pass

func Play(Move):
	Move.ActOn(self)
	emit_signal("MovePlayed", self)
