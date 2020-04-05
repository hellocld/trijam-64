extends Area

class_name Fireball

export var speed = 8

var dir:Vector3

func _ready():
	connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
	translate(dir * delta * speed)

func on_body_entered(var b):
	if(b.has_method("take_damage")):
		b.take_damage()
	queue_free()


func _on_TimerLife_timeout():
	queue_free()
