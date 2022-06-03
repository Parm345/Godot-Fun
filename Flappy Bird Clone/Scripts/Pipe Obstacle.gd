extends Node2D

signal passedPipes(scoreValue)

export var speed = 50
export var greenPipeScore = 1
export (PackedScene) var greenPipe
export (PackedScene) var redPipe

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var random = RandomNumberGenerator.new()
var score
var isMoving = true
var pointTaken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	
	var pipe1
	var pipe2
	match(random.randi_range(1,5)):
		1:
			pipe1 = redPipe.instance()
			pipe2 = redPipe.instance()
			score = greenPipeScore*2
		_:
			pipe1 = greenPipe.instance()
			pipe2 = greenPipe.instance()
			score = greenPipeScore
	
	pipe1.position = $Position2D.position
	pipe2.position = -$Position2D.position
	pipe2.get_node("Sprite").set_flip_v(true) 
	add_child(pipe1)
	add_child(pipe2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isMoving:
		position.x -= speed*delta

func setSpeed(newSpeed):
	speed = newSpeed

func getSpeed():
	return speed

func _on_Area2D_body_exited(body):
	if !pointTaken:
		#print(score)
		emit_signal("passedPipes", score)
		pointTaken = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
