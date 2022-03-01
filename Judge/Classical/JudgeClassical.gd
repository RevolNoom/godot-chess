extends Judge

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func GetStartingFEN() -> String:
	return 	"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
	
	
func Play(_UCI):
	if GetLegalMoves().has(_UCI):
		_Board.Play(GetLegalMoves()[_UCI])
		_legalMovesCache = null
		_WhiteTurn = not _WhiteTurn
	ContinueTheGame()
	
	
func Status():
	return "-"


# Return a dictionary of {UCI: Move}
func GetLegalMoves():
	if _legalMovesCache == null:
		__UpdateLegalMoves()
	return _legalMovesCache

# PROTECTED:

func __UpdateLegalMoves():
	_legalMovesCache = {}
	var it = _Board.Iterable()
	while it.HasMore():
		__MergeLegalMoves(_legalMovesCache, it.GetNext().GetValidMoves())


# Merge Another dictionary to Merged dictionary
# If Another dictionary has some Merged's existing keys,
# Those values in Merged will be modified to Another's new values
func __MergeLegalMoves(movesDictMerged: Dictionary, movesDictAnother: Dictionary):
	var newKeys = movesDictAnother.keys()
	for k in newKeys:
		movesDictMerged[k] = movesDictAnother[k]
	

var _legalMovesCache
