extends KinematicBody2D

export (float) var SPEED = 160
export (float) var MAX_HEALTH = 100

onready var health = MAX_HEALTH

var dead = false
var velocity : Vector2 = Vector2()

signal health_change
signal im_dead

func _ready():
	emit_signal("health_change",health)


func _input(event):
	velocity = event_move(velocity, event)


func _physics_process(_delta):
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func hurt(amount):
	health-=amount
	#esto podría ir en un setter
	if health <= 0:
		if !dead:
			emit_signal("im_dead")
			dead = true
			set_physics_process(false) 
		health = 0
		return
	elif health > 100:
		health = 100
	emit_signal("health_change",health)


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
