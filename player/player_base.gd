extends KinematicBody2D
class_name PlayerBase

export (float) var SPEED = 160
export (float) var MAX_HEALTH = 100

onready var health = MAX_HEALTH setget set_health

var dead = false

signal health_change
signal im_dead

func _ready():
	emit_signal("health_change",health)


func hurt(amount):
	self.health-=amount


func set_health(new_health) -> void:
	health = new_health
	if health <= 0:
		health = 0
		if !dead:
			emit_signal("im_dead")
			dead = true
			set_physics_process(false)
	elif health > MAX_HEALTH:
		health = MAX_HEALTH
		emit_signal("health_change",health)
