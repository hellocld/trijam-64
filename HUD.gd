extends Control
signal restart_game

func set_score(var score):
	$"Score".text = "SCORE: %d" % score


func set_health(var health):
	$"Health".value = health


func game_over():
	$GameOver.visible = true
	$Button.visible = true


func _on_Button_pressed():
	emit_signal("restart_game")
