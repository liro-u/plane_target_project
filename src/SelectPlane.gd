extends TextureButton

func _ready():
	var popup = get_tree().get_nodes_in_group("popup_plane_image")
	if popup.size() > 0:
		connect("pressed", popup[0], "popup")
		popup[0].connect("file_selected", self, "set_plane_image")

func set_plane_image(path):
	var plane_image = load(path)
	texture_normal = plane_image
	get_tree().get_nodes_in_group("plane")[0].texture = plane_image
