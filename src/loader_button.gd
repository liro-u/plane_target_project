extends Button

export(String) var path

func is_pressed():
	get_tree().call_group_flags(2,"scene_manager", "switch_scene_with", path)
