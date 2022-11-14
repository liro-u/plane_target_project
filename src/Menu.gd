extends MarginContainer

var global_data_path = "res://data/global_data.tres"

func _ready():
	var global_data = load(global_data_path).duplicate()
	get_tree().get_nodes_in_group("hight_score")[0].text = "record : " + str(global_data.hight_score)
