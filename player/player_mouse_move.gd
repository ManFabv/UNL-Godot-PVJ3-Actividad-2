extends KinematicBody2D

export (float) var SPEED = 160
export (float) var MAX_HEALTH = 100
export (float) var REACH_DESTINATION_THRESHOLD = 3

onready var health = MAX_HEALTH

var dead = false
var destination : Vector2 = Vector2()
var reached_destination : bool = true

signal health_change
signal im_dead

func _ready():
	emit_signal("health_change",health)


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


func click_to_move(movement : Vector2) -> Vector2:
	movement = position.direction_to(destination) * SPEED
	
	return movement
