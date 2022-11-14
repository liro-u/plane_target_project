extends Node

func _physics_process(delta):
	if Input.is_action_just_pressed("save_new_plane_data"):
		save_plane_data()

func save_plane_data():
	var path = "res://asset/PlaneData/"
	var plane_name = get_parent().get_node("FileName").text
	
	if plane_name == "":
		var plane_number = 0
		var dir = Directory.new()
		plane_name =  "nouvel_avion_" + str(plane_number)
		while dir.file_exists(path + plane_name + ".tres"):
			plane_number += 1
			plane_name =  "nouvel_avion_" + str(plane_number)
	
	var plane = get_tree().get_nodes_in_group("plane")[0]
	var data = PlaneData.new()
	data.plane_image = plane.texture
	data.plane_position = plane.rect_position
	data.plane_name = plane_name
	data.plane_speed = get_parent().get_node("SpeedInfo").text
	ResourceSaver.save(path + plane_name + ".tres", data)
