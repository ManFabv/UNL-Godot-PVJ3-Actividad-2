extends Node2D

const main_controller_selection_scene = "res://main_controller_selection.tscn"

func _input(event):
	if (event.is_action_pressed("select_controller")):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(main_controller_selection_scene)
