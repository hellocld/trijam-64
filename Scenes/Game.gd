extends Spatial

onready var player_node:KinematicBody = $"Player"

func _ready():
	$"Enemy".target = player_node
	player_node.connect("dead", self, "game_over")
	$GameCam.target = player_node

func _game_over():
	$GameCam.target = null
