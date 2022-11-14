extends FileDialog

func stop():
	get_parent().mouse_filter = MOUSE_FILTER_STOP
	get_tree().get_nodes_in_group("plane")[0].disabled_movement()
	
func ignore():
	get_parent().mouse_filter = MOUSE_FILTER_IGNORE
	get_tree().get_nodes_in_group("plane")[0].can_move = true
