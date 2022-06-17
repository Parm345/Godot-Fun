extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var numLinks = 3
export var origin = Vector2(512, 300)

var link = preload("res://Scenes/Arm Link.tscn")
var linkList = []
#onready var link1 = get_child(0) # onready is equivalent to putting it in _ready 
var finalLink

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(numLinks):
		var newLink = link.instance()
		linkList.append(newLink)
		print(i)
		if i > 0:
			newLink.position = linkList[i-1].get_node("Pointer End").global_position 
		else:
			newLink.position = origin
		add_child(newLink)
	inverseKinematics(get_viewport().get_mouse_position())
	
#	print(finalLink.get_parent().name)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
#	finalLink.look_at(mousePos)
	inverseKinematics(mousePos)

func inverseKinematics(mousePos):
	for i in range(linkList.size()-1, -1, -1):
		if i == numLinks - 1: # Step 1: Point last link at mousePos
			linkList[i].look_at(mousePos)
			var diff = linkList[i].get_node("Pointer End").global_position - linkList[i].position
			linkList[i].global_position = mousePos - diff
		else: # Step 2: point links at link before it
			linkList[i].look_at(linkList[i+1].position)
			var diff = linkList[i].get_node("Pointer End").global_position - linkList[i].position
			linkList[i].global_position = linkList[i+1].position - diff
			
	
	# Step 3: Return arm to origin, remove if you want snake 
	for i in range (numLinks):
		if i == 0:
			linkList[i].position = origin
		else:
			linkList[i].position = linkList[i - 1].get_node("Pointer End").global_position
