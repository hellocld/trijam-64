extends KinematicBody

signal dead

enum State { IDLE, MOVING, ATTACKING }
var state = State.IDLE

export var speed = 60
export var attack_dist = 1.1
export var health = 1

var target:KinematicBody
onready var sprite = $"Sprite3D"
onready var attack_cooldown = $"AttackCooldown"

func _physics_process(delta):
	if target == null:
		return
	
	match state:
		State.IDLE:
			if attack_cooldown.get_time_left() <= 0:
				state = State.MOVING
		State.MOVING:
			var dist_to_target = transform.origin.distance_to(target.transform.origin)
			if attack_cooldown.get_time_left() <= 0 && dist_to_target < attack_dist:
				state = State.ATTACKING
			var move_dir = (target.transform.origin - transform.origin).normalized()
			if move_dir.x < 0:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
			move_and_slide(move_dir * speed * delta, Vector3.UP)
		State.ATTACKING:
			$AudioStreamPlayer3D.play()
			target.take_damage()
			attack_cooldown.start()
			state = State.IDLE


func take_damage():
	health -= 1
	if health <= 0:
		emit_signal("dead")
		queue_free()


func game_over():
	print("Enemy game over")
	target = null
