extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var numLinks = 3
export var origin = Vector2(512, 300)

var link = preload("res://Scenes/Arm Link.tscn")
#onready var link1 = get_child(0) # onready is equivalent to putting it in _ready 
var finalLink

# Called when the node enters the scene tree for the first time.
func _ready():
	var curLink = null
	for i in range(numLinks):
		var newLink = link.instance()
#		newLink.name = str(i)
		if curLink != null:
			newLink.position = curLink.get_node("Pointer End").position
			curLink.add_child(newLink)
		else:
			newLink.position = origin
			add_child(newLink)
		curLink = newLink
		
	finalLink = curLink
#	inverseKinematics(get_viewport().get_mouse_position()
#	print(finalLink.get_parent().name)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
#	finalLink.look_at(mousePos)
	inverseKinematics(mousePos)

func inverseKinematics(mousePos):
	
	# Step 1
	finalLink.look_at(mousePos) # point final link at mousePos
	finalLink.set_global_position(mousePos + finalLink.get_node("Pointer End").position)# move final link to mousePos 
	
	# Step 2
	var curLink = finalLink.get_parent()
	for i in range(numLinks -1):
		curLink.look_at(curLink.get_child(0).position)# point curLink at base of child
		# move curLink to base of child
		curLink.set_global_position(curLink.get_child(0).global_position + curLink.get_node("Pointer End").position)
		curLink = curLink.get_parent()
	
	# Step 3
	curLink.position = origin# return base back to origin, comment out if you want a snake  
