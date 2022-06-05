extends PlayerBase

func _physics_process(_delta):
	var velocity = polling_move()
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func polling_move() -> Vector2:
	var movement = Vector2()
	if (Input.is_action_pressed("move_up")):
		movement += Vector2(0, -1)
	if (Input.is_action_pressed("move_bottom")):
		movement += Vector2(0, 1)
	if (Input.is_action_pressed("move_left")):
		movement += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		movement += Vector2(1, 0)
		
	movement = movement.normalized()*SPEED
	
	return movement
