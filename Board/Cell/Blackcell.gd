extends StaticBody2D

# A Cell never lives outside a board
# So, every methods here assume that its parent is a Board
# And that it has been configured correctly

# Return the parent board of this Cell
func Board():
	return get_parent()
	
# Return the cell's name (a1-h8)
func GetName():
	return get_name()
