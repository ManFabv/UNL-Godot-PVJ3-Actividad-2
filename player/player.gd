extends KinematicBody2D

export (float) var SPEED = 160
export (float) var MAX_HEALTH = 100

onready var health = MAX_HEALTH

var dead = false

signal health_change
signal im_dead

func _ready():
	emit_signal("health_change",health)


func _physics_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("move_bottom")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	
	var velocity = motion.normalized()*SPEED
	
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
