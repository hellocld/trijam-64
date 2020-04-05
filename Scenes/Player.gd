extends KinematicBody

var speed = 30
var input:Vector2

func _physics_process(delta):
	input = Vector2.ZERO
	if Input.is_action_pressed("player_down"):
		input.y += 1
	if Input.is_action_pressed("player_left"):
		input.x -= 1
	if Input.is_action_pressed("player_right"):
		input.x += 1
	if Input.is_action_pressed("player_up"):
		input.y -= 1
	input = input.normalized()
	if input.length() > 0:
		move_and_slide(
				Vector3(input.x, 0, input.y) * speed * delta,
				Vector3.UP
		)
