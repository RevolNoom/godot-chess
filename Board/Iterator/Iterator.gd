extends Reference
class_name Iterator
# Base (helper) class for Iterator classes

# PROTECTED:

func __Get():
	print("Get: " + IndicesToCellName(_curPos))
	var pieces = _board.get_node(IndicesToCellName(_curPos)).get_children()
	print("Children size: " + str(pieces.size()))
	for p in pieces:
		if p is Piece:
			return p
	return null
		


var _board
var _curPos = [0, 0]
		
# Return an array of 2 integers: [row, column]
func CellNameToIndices(cellName):
	return [_strToIndices[cellName[0]], _strToIndices[cellName[1]]]
	
	
func IndicesToCellName(indices):
	return _indicesToStr[indices[0]][0] +  _indicesToStr[indices[1]][1]
	
	
const _strToIndices = {
	"a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7,
	"1": 0, "2": 1, "3": 2, "4": 3, "5": 4, "6": 5, "7": 6, "8": 7}


const _indicesToStr = {
	0: ["a", "1"], 1: ["b", "2"], 2: ["c", "3"], 3: ["d", "4"], 
	4: ["e", "5"], 5: ["f", "6"], 6: ["g", "7"], 7: ["h", "8"]}
