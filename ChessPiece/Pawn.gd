extends Piece

export var _DoubleMove = true

func Notation():
	if self._white:
		return "P"
	return "p"
	
func GetValidMoves():
	var board = GetBoard()
	
	var position = board.CellNameToIndices(GetPosition())
	
	var _direction_ = {self.WHITE: 1, self.BLACK: -1}
	var dir = _direction_[_IsWhite]
	
	# Return only one forward move
	#TODO: More available moves
	# Create pseudo pawn when double move (for en passant)
	
	var tempMove = Mobilize.new(GetPosition(), board.IndicesToCellName(position[0]+dir, position[1]))
	return {GetPosition()+board.IndicesToCellName(position[0]+dir, position[1]): tempMove}
