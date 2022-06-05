extends PlayerBase

var velocity : Vector2 = Vector2()

func _input(event):
	velocity = event_move(velocity, event)


func _physics_process(_delta):
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func event_move(motion : Vector2, event : InputEvent) -> Vector2:
	#solo necesito la direccion para continuar trabajando con el movimiento
	motion = motion.normalized()
	
	if (event.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
	if (event.is_action_pressed("move_bottom")):
		motion += Vector2(0, 1)
	if (event.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (event.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	
	#si dejo de presionar una tecla y no tengo movimiento en el sentido contrario
	if (event.is_action_released("move_up") && motion.y < 0):
		motion.y = 0
	if (event.is_action_released("move_bottom") && motion.y > 0):
		motion.y = 0
	if (event.is_action_released("move_left") && motion.x < 0):
		motion.x = 0
	if (event.is_action_released("move_right") && motion.x > 0):
		motion.x = 0
	
	motion = motion.normalized()*SPEED
	
	return motion
