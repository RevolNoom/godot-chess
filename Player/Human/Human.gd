extends Player

var _BoardNeedsService
var _PickedPiece


func _ready():
	_BoardNeedsService = null
	_PickedPiece = null
	set_process_input(false)
	
	
func HandleMoveRequest(board):
	print("Handling move request: " + name)
	_BoardNeedsService = board
	_PickedPiece = null
	set_process_input(true)
	
	
# Handle pieces drag and drop
func _input(event):
	if not event is InputEventMouse:
		return
	__HandleMouseDrag(event)
	__HandleMousePress(event)


# Move the Pointer along with Mouse
# And take note of the hovered piece
func __HandleMouseDrag(event):
	if event is InputEventMouseMotion:
		__UpdateHandpickPosition()
		__MoveDraggedPiece()


func __PieceHoveredOver():
	var collideInfo = $Handpick.move_and_collide(Vector2(0,0.01), true, true, true)
	if collideInfo != null and collideInfo.get_collider() != null:
		return collideInfo.get_collider()
	return null


func __UpdateHandpickPosition():
	$Handpick.set_global_position($Handpick.get_global_mouse_position())
	

func __HandleMousePress(event):
	if event is InputEventMouseButton:
		# We're clicking for the first time in a while
		if event.is_pressed():
			__TryToGrabAPiece()
		else:
			__DropPieceOnACell()


func __MoveDraggedPiece():
	if _PickedPiece != null:
		_PickedPiece.set_global_position($Handpick.get_global_position())
		

func __TryToGrabAPiece():
	var HoveredPiece = __PieceHoveredOver()
	if _PickedPiece == null and HoveredPiece != null:
		_PickedPiece = HoveredPiece
		_PickedPiece.add_collision_exception_with($Handpick)
		
		
# Either drop the piece on a Cell and emit a move
# Or abort and ask the judge to try again
func __DropPieceOnACell():
	if _PickedPiece != null:
		var HoveredCell = _PickedPiece.CellHoveredOver()
		if HoveredCell != null:
			set_process_input(false)
			emit_signal("MoveConstructed",  _PickedPiece.GetPosition() + HoveredCell.GetName())
			_PickedPiece = null
		else:
			emit_signal("AskRetryMove")

	
