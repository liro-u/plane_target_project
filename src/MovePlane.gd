extends TextureRect

var need_move_plane = false
var can_move = true

func disabled_movement():
	need_move_plane = false
	can_move = false
	
func _unhandled_input(event):
	if can_move and event is InputEventScreenTouch:
		need_move_plane = event.pressed

func _process(delta):
	if need_move_plane:
		rect_global_position = get_viewport().get_mouse_position() - rect_size / 2
	
