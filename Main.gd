extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$JudgeClassical.SetPlayer($Human, $Human2)
	$JudgeClassical.SetBoard($Board)
	
	var it = $Board.Iterable()
	print ("HasMore: " + str(it.HasMore()))
	while it.HasMore():
		var p = it.GetNext()
		print(p.GetName())
	
	$JudgeClassical.StartGame()
