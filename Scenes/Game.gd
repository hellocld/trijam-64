extends Spatial

onready var player_node:KinematicBody = $"Player"

export(PackedScene) var enemy
export var size:Vector2

var rng:RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	player_node.connect("dead", self, "game_over")
	$GameCam.target = player_node

func _game_over():
	$GameCam.target = null
	$Enemy.target = null


func _on_TimerSpawn_timeout():
	print("Spawning enemy")
	var e = enemy.instance()
	e.target = player_node
	connect("game_over", e, "game_over")
	add_child(e)
	e.transform.origin = Vector3(rng.randi_range(-size.x/2, size.x/2), 0, rng.randi_range(-size.y/2, size.y/2))
