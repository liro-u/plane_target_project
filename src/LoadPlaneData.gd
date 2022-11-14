extends Button

export var basic_pos = Vector2(832, -15)

func _ready():
	var popup = get_tree().get_nodes_in_group("popup_load_plane")
	if popup.size() > 0:
		connect("pressed", popup[0], "popup")
		popup[0].connect("file_selected", self, "load_plane", [true])

func load_plane(path, dev = false):
	var plane_data = load(path)
	var plane_image = get_parent().get_node("PlaneImage")
	if plane_image is TextureButton:
		plane_image.texture_normal = plane_data.plane_image
	elif plane_image is TextureRect:
		plane_image.texture = plane_data.plane_image
	var plane = get_tree().get_nodes_in_group("plane")[0]
	plane.texture = plane_data.plane_image
	get_parent().get_node("SpeedInfo").text = plane_data.plane_speed
	if dev:
		get_tree().get_nodes_in_group("plane")[0].rect_position = plane_data.plane_position
		var file_name = get_parent().get_node("FileName")
		file_name.text = plane_data.plane_name
	else:
		text = "valider"
		get_tree().get_nodes_in_group("reponse")[0].rect_position = plane_data.plane_position
		plane.rect_position = basic_pos
		plane.can_move = true
	
