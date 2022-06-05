extends Node2D

const click_to_move_scene = "res://player_controller/main_click_to_move.tscn"
const event_move_scene = "res://player_controller/main_event_move.tscn"
const mouse_move_scene = "res://player_controller/main_mouse_move.tscn"
const polling_move_scene = "res://player_controller/main_polling_move.tscn"

func _input(event):
	if (event.is_action_pressed("select_click_to_move")):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(click_to_move_scene)
		
	if (event.is_action_pressed("select_event_move")):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(event_move_scene)
		
	if (event.is_action_pressed("select_mouse_move")):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(mouse_move_scene)
		
	if (event.is_action_pressed("select_polling_move")):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(polling_move_scene)
