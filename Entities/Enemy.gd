extends KinematicBody

export var speed = 60
export var attack_dist = 1
var target:KinematicBody
onready var sprite = $"Sprite3D"
func _physics_process(delta):
	if transform.origin.distance_to(target.transform.origin) > attack_dist:
		var move_dir = (target.transform.origin - transform.origin).normalized()
		if move_dir.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		move_and_slide(move_dir * speed * delta, Vector3.UP)

