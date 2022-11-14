extends "res://src/LoadPlaneData.gd"

var planes = []
var path = "res://asset/PlaneData/"
var response_is_show = false
var score = 0
var nb_plane_done = 0
var path_global_data = "res://data/global_data.tres"
var hight_score = 0
export var nb_plane_to_do = 3
export var max_score = 500
export var lost_by_distance = 12
export var error_marge = 90

func _ready():
	randomize()
	var global_data = load(path_global_data)
	hight_score = global_data.hight_score
	planes = GetFile.list_file_in_directory(path)
	new_game()
	
func load_random_plane():
	var plane_path = path + planes[randi() % planes.size()]
	load_plane(plane_path)
	
func is_pressed():
	var plane = get_tree().get_nodes_in_group("plane")[0]
	if !response_is_show:
		plane.disabled_movement()
		score += point_calculation()
		if score > hight_score:
			hight_score = score
			var final_global_data = load(path_global_data).duplicate()
			final_global_data.hight_score = hight_score
			ResourceSaver.save(path_global_data, final_global_data)
		nb_plane_done += 1
		update_label()
		plane.rect_position = get_tree().get_nodes_in_group("reponse")[0].rect_position
		text = "avion suivant"
	#reload un avion si pas fini sinon la popup
	else:
		if nb_plane_done < nb_plane_to_do:
			load_random_plane()
		else:
			disabled = true
	response_is_show = !response_is_show

func new_game():
	load_random_plane()
	nb_plane_done = 0
	score = 0
	update_label()
	disabled = false

func update_label():
	get_tree().get_nodes_in_group("tour_label")[0].text = "avion " + str(nb_plane_done) + " / " + str(nb_plane_to_do)
	get_tree().get_nodes_in_group("score_label")[0].text = "score : " + str(score)
	get_tree().get_nodes_in_group("higth_score_label")[0].text = "hight score : " + str(hight_score)

func point_calculation():
	var response = get_tree().get_nodes_in_group("reponse")[0]
	var plane = get_tree().get_nodes_in_group("plane")[0]
	var distance2response = plane.rect_position.distance_to(response.rect_position)
	return round(max(0, min(max_score, max_score + error_marge - distance2response * lost_by_distance)))
