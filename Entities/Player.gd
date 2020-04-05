extends KinematicBody

signal dead
signal damaged

export(PackedScene) var fireball
export var speed = 30
var input:Vector2

var health = 3
onready var max_health:float = health

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
	
	if Input.is_action_pressed("player_fire"):
		return # Can't move while shooting
	if input.length() > 0:
		move_and_slide(
				Vector3(input.x, 0, input.y) * speed * delta,
				Vector3.UP
		)

func take_damage():
	health -= 1
	emit_signal("damaged", (health/float(max_health)) * 100)
	if health <= 0:
		print("Dead")
		emit_signal("dead")


func _on_FireTimer_timeout():
	if Input.is_action_pressed("player_fire"):
		var dir = Vector3.ZERO
		if Input.is_action_pressed("player_down"):
			dir.z += 1
		if Input.is_action_pressed("player_up"):
			dir.z -= 1
		if Input.is_action_pressed("player_left"):
			dir.x -= 1
		if Input.is_action_pressed("player_right"):
			dir.x += 1
		if dir == Vector3.ZERO:
			return
		dir = dir.normalized()
		var f = fireball.instance() as Fireball
		get_tree().root.add_child(f)
		f.transform.origin = transform.origin
		f.dir = dir
		$AudioStreamPlayer3D.play()
