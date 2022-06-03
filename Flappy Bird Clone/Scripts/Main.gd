extends Node2D

export var groundLocation = 395
export (PackedScene) var pipeObstacle
export (Texture) var bgDay
export (Texture) var bgNight

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score = 0
var worldSpeed = 50
var spawnPosition

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var bgNumber = rng.randi_range(1, 2)
	
	match(bgNumber):
		1:
			$Background.texture = bgDay
		2: 
			$Background.texture = bgNight
	spawnPosition = $Player.position
	$Player.groundLocation = groundLocation
	$Player.gravity = 0
	$Player.rotateSpeed = 0
	$Player.birdIsAlive = false

func spawnPipe():
	var newPipe = pipeObstacle.instance()
	newPipe.position.x = $"Spawn Location".position.x
	newPipe.position.y = rng.randi_range(100, groundLocation - 100)
	newPipe.connect("passedPipes", self, "pointScored")
	newPipe.setSpeed(worldSpeed)
	add_child(newPipe)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_gameLost(body):
	if body != get_node("BaseBarrier"):
		$"Fall Sound".play()
	var childArray = get_children()
	for child in childArray:
		if child.has_method("setSpeed"):
			child.setSpeed(0)
	$HUD/StartButton.show()


func _on_Difficulty_Timer_timeout():
	worldSpeed *= 1.25
	for child in get_children():
		if child.has_method("setSpeed"):
			child.setSpeed(worldSpeed)

func _on_Area2D_area_exited(area):
	spawnPipe()

func pointScored(scoreIncrease):
	score += scoreIncrease
	$HUD/ScoreLabel.text = str(score)
	
func _on_HUD_startGame():
	get_tree().call_group("Obstacle", "queue_free")
	$HUD/Message.hide()
	$HUD/StartButton.hide()
	worldSpeed = 80
	score = 0
	$HUD/ScoreLabel.text = str(score)	
	spawnPipe()
	$Player.gravity = 9.81
	$Player.rotateSpeed = 2
	$Player.birdIsAlive = true
	$Player.position = spawnPosition
	$Player.velocity = Vector2(0, 0)
	
