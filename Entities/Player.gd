extends KinematicBody

export var speed = 30
var input:Vector2

var health = 3

onready var sprite = $"Sprite3D"


func _physics_process(delta):
	input = Vector2.ZERO
	if Input.is_action_pressed("player_down"):
		input.y += 1
	if Input.is_action_pressed("player_left"):
		sprite.flip_h = true
		input.x -= 1
	if Input.is_action_pressed("player_right"):
		sprite.flip_h = false
		input.x += 1
	if Input.is_action_pressed("player_up"):
		input.y -= 1
	input = input.normalized()
	if input.length() > 0:
		move_and_slide(
				Vector3(input.x, 0, input.y) * speed * delta,
				Vector3.UP
		)

func take_damage():
	health -= 1
	if health <= 0:
		dead()
	else:
		print_debug("Ouch!")


func dead():
	print_debug("You're dead!")
	queue_free()
