extends CanvasLayer

signal start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_score(score):
	$Score.text = str(score)

func _on_StartButton_pressed():
	emit_signal("start")
	$Message.hide()
	$StartButton.hide()

func _on_Ball_game_over():
	$Message.show()
	$Message.text = "Game Over!"
	$GameOver.start()

func _on_GameOver_timeout():
	$Message.text = "Lonely Pong"
	$StartButton.show()
