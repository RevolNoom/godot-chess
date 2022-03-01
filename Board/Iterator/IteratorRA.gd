extends Iterator
class_name IteratorRA
# Iterator that supports random cell access
# and modification

func _init(board).():
	_board = board


func Get():
	return __Get()
	
func Add(piece):
	_board.Add(piece, IndicesToCellName(_curPos))
	
	
func Remove() -> Piece:
	return _board.Remove(IndicesToCellName(_curPos))
	
	
# Move the iterator to a random cell
# @Cell: a string of cell name,
#		 or Array of two indices integers
func GoTo(Cell):
	if Cell is String:
		Cell = CellNameToIndices(Cell)
	_curPos = Cell
	
	
# Move the iterator @col columns, @row rows
func Travel(col, row):
	_curPos[0] += col
	_curPos[1] += row

# Move both piece and iterator @col columns, @row rows
func MovePiece(col, row):
	var from = __Get().GetPosition() 
	Travel(col, row)
	var to = __GetPos()
	_board.Mobilize(from, to)


# Return a Piece at the specified cell
# Null if no piece is found
#
# NOTE: At() Does _NOT_ move the iterator
# @Cell: a string of cell name,
#		 or Array of two indices integers
func At(Cell) -> Piece:
	if Cell is String:
		Cell = CellNameToIndices(Cell)
	var pieces = _board.get_node(self.IndicesToCellName(_curPos)).get_children()
	if pieces.size() == 1:
		return pieces[0]
	return null
	
# PRIVATE:

# Return the name of current cell
# that this Iterator is pointing to
func __GetPos():
	return IndicesToCellName(_curPos)
