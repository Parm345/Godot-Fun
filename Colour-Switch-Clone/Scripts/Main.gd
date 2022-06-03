extends Node2D

onready var global = $"/root/Global"

export (PackedScene) var colour_circle
export (PackedScene) var switch_circle

var spawner_distance = 0
var switch_delay = false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner_distance = $Player.position.y - $ObjectSpawnLocation.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var index = rng.randi_range(0, 1)
	
	$ObjectSpawnLocation.position.y = $Player.position.y - spawner_distance
	if global.spawnable == true:
		randomize()
		if index == 0 and switch_delay == false:
			spawnSwitch()
			switch_delay = true
		else:
			spawnCircle()
			switch_delay = false
	
func spawnSwitch():
	var switch = switch_circle.instance()
	add_child(switch)
	switch.position = $ObjectSpawnLocation.position
	global.spawnable = false
	
func spawnCircle():
	var circle = colour_circle.instance()
	add_child(circle)
	circle.position = $ObjectSpawnLocation.position
	circle.scale = Vector2(0.6,0.6)
	global.spawnable = false
	
	
	
