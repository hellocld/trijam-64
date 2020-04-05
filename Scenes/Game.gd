extends Spatial
signal game_over

export(PackedScene) var enemy
export var size:Vector2

var rng:RandomNumberGenerator
var score = 0

func _ready():
	rng = RandomNumberGenerator.new()
	$Player.connect("dead", self, "game_over")
	$GameCam.target = $Player
	$Player.connect("damaged", $HUD, "set_health")
	$HUD.connect("restart_game", self, "restart")
	
func game_over():
	print("Game over")
	emit_signal("game_over")
	$GameCam.target = null
	$Enemy.target = null
	$HUD.game_over()
	$TimerSpawn.stop()
	$Player.queue_free()


func _on_TimerSpawn_timeout():
	print("Spawning enemy")
	var e = enemy.instance()
	e.target = $Player
	e.connect("dead", self, "add_score")
	connect("game_over", e, "game_over")
	add_child(e)
	e.transform.origin = Vector3(rng.randi_range(-size.x/2, size.x/2), 0, rng.randi_range(-size.y/2, size.y/2))


func restart():
	get_tree().reload_current_scene()


func add_score():
	score += 100
	$HUD.set_score(score)
