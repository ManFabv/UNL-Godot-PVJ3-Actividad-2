extends PlayerBase

export (float) var REACH_DESTINATION_THRESHOLD = 3

var destination : Vector2 = Vector2()
var reached_destination : bool = true

func _ready():
	destination = position


func _input(event):
	if event.is_action_pressed("click_to_move"):
		destination = get_global_mouse_position()
		reached_destination = false


func _physics_process(_delta):
	if (!reached_destination):
		var velocity = click_to_move()
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)
		check_if_reached_destination()


func check_if_reached_destination() -> void:
	if(destination.distance_to(position) < REACH_DESTINATION_THRESHOLD):
		reached_destination = true
	else:
		reached_destination = false


func click_to_move() -> Vector2:
	var movement = position.direction_to(destination) * SPEED
	
	return movement
