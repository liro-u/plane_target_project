extends Node

export(PackedScene) var starting_scene

var editor_path = "res://DataSaver.tscn"
var actual_scene
onready var animPlayer = $"CanvasLayer/AnimationPlayer"

func _ready():
	actual_scene = starting_scene.instance()
	add_child(actual_scene)

func switch_scene_with(path):
	start_hiding_animation()
	yield(animPlayer, "animation_finished")
	var next_scene = load(path).instance()
	add_child(next_scene)
	actual_scene.queue_free()
	actual_scene = next_scene
	start_showing_animation()
	yield(animPlayer, "animation_finished")

func start_hiding_animation():
	animPlayer.current_animation = "hide"
func start_showing_animation():
	animPlayer.current_animation = "show"

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_to_editor"):
		switch_scene_with(editor_path)
