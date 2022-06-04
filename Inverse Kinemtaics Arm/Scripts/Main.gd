extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var link1 = $"Arm Link 1"
onready var link2 = $"Arm Link 2"

# Called when the node enters the scene tree for the first time.
func _ready():
	link2.position = link1.get_node("Pointer End").global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
#	$"Arm Link 1".set_rotation(atan2(mousePos.y-$"Arm Link 1".position.y, mousePos.x-$"Arm Link 1".position.x )-deg2rad(90))
	inverseKinematics(mousePos)

func inverseKinematics(mousePos):
	var desiredPos = mousePos - link1.position
	var theta = atan2(desiredPos.y, desiredPos.x)
	var phi1 = acos(pow(desiredPos.length(),2)/(2*link2.armLength*desiredPos.length())) # simplified cosine law 
	link1.set_rotation(theta+phi1 -deg2rad(180))
	var phi2 = (mousePos - link1.get_node("Pointer End").position).angle()
	link2.position = link1.get_node("Pointer End").global_position
	
