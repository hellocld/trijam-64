extends Spatial

onready var player_node:KinematicBody = $"Player"

func _ready():
	$"Enemy".target = player_node
