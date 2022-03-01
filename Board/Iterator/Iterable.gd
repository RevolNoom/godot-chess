extends Iterator
class_name Iterable

# An Object helps with Board traversal

func _init(board).():
	self._board = board
	

func HasMore():
	return __MoveToNextPiecePosition() != null
	

# Return a piece this iterator points to
# Null if it points to nothing.
func GetNext() -> Piece:
	__MoveToNextPiecePosition()
	return self.__Get()
	


# PRIVATE:

func __MoveToNextPiecePosition():
	print("Travelling:")
	while _curPos[1] < 8 and _curPos[0] < 8:	
		print(str(_curPos[0]) + str(_curPos[1]))
		_curPos[0] += 1
		if _curPos[0] >= 8:
			_curPos[0] = 0
			_curPos[1] += 1
		if _curPos[1] >= 8:
			return null
		if __Get() != null:
			return _curPos			
	return null
