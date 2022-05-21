extends PlayerBase

export (float) var REACH_DESTINATION_THRESHOLD = 3

var destination : Vector2 = Vector2()
var reached_destination : bool = true


func _physics_process(_delta):
	destination = get_global_mouse_position()
	
	check_if_reached_destination()
	
	if (!reached_destination):
		var motion = Vector2()
		var velocity = Vector2()
		
		velocity = click_to_move(motion)
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)


func check_if_reached_destination() -> void:
	if(destination.distance_to(position) < REACH_DESTINATION_THRESHOLD):
		reached_destination = true
	else:
		reached_destination = false


func click_to_move(movement : Vector2) -> Vector2:
	movement = position.direction_to(destination) * SPEED
	
	return movement
