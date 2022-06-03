extends Node2D

var score = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ball_hit():
	score += 1
	$GUI.update_score(score)

func _on_GUI_start_button():
	$BallSpawn.start()
	$Ball.position = $Position2D.position

func _on_Ball_game_over():
	$Ball.hide()
	$Ball.position = $Position2D.position
	score = 0
	$GUI.update_score(score)
