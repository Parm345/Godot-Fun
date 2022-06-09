extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var link1 = $"Arm Link 1"
onready var link2 = link1.get_node("Arm Link 2")

var quadrant = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	link2.position = link1.get_node("Pointer End").position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
	var relativePos = mousePos - link1.position
	#print(mousePos)
#	$"Arm Link 1".set_rotation(atan2(mousePos.y-$"Arm Link 1".position.y, mousePos.x-$"Arm Link 1".position.x )-deg2rad(90))
	var quadrant = determineQuadrant(relativePos)
	inverseKinematics(relativePos.abs(), quadrant)
	link2.position = link1.get_node("Pointer End").position

# mirror conventional quadrants 
func determineQuadrant(relativePos):
	if relativePos.x == 0 or relativePos.y == 0:
		return 0
	elif relativePos.x > 0:
		if relativePos.y > 0:
			return 1
		else:
			return 4
	else:
		if relativePos.y > 0:
			return 2
		else:
			return 3

func inverseKinematics(relativePos, quadrant):
	if quadrant == 0:
		link2.set_rotation(0)
		if relativePos.x > 0:
			link1.set_rotation(deg2rad(90))
		elif relativePos.x < 0:
			link1.set_rotation(deg2rad(270))
		elif relativePos.y > 0:
			link1.set_rotation(deg2rad(180))
		else:
			link1.set_rotation(deg2rad(0))
	else:
		var zeta = atan(relativePos.y/relativePos.x)
		var r = relativePos.length()
		if r > sqrt(pow(link1.armLength, 2) + pow(link2.armLength, 2)):
			r = sqrt(pow(link1.armLength, 2) + pow(link2.armLength, 2))
		
		# use cosine law 
		var omega = acos(
			(pow(link1.armLength,2)+pow(r,2)-pow(link2.armLength, 2))/
			(2*r*link1.armLength))
		
		var link2RelativeEE = (relativePos - link2.position).abs()
		var beta = atan2(link2RelativeEE.y, link2RelativeEE.x)
		
		var theta = omega + zeta - beta
		if abs(relativePos.y) < abs(link1.get_node("Pointer End").position.y):
			theta = 90 + beta
		var alpha
		
		if quadrant == 1:
			theta = -theta
			alpha = deg2rad(270)+zeta+omega
		elif quadrant == 2:
			alpha = deg2rad(90) - zeta - omega
		elif quadrant == 3:
			theta = -theta
			alpha = deg2rad(90) + zeta + omega 
		else:
			alpha = deg2rad(270) - zeta - omega 
			
		link1.set_rotation(alpha)
		link2.set_rotation(theta)

#func inverseKinematics(mousePos):
#	var desiredPos = (mousePos - link1.position)
#	var desiredPosLength = desiredPos.length()
#	if desiredPosLength > (link1.armLength + link2.armLength):
#		desiredPosLength = link1.armLength + link2.armLength
#	var theta = atan2(desiredPos.y, desiredPos.x)
#	var phi1 = acos(pow(desiredPosLength,2)/(2*link2.armLength*desiredPos.length())) # simplified cosine law 
#	link1.set_rotation(theta+phi1-deg2rad(90))
#	#print(rad2deg(theta+phi1))
#	var phi2 = (mousePos - link1.get_node("Pointer End").global_position).angle()
##	print(rad2deg(phi2))
#	link2.set_rotation(-phi1)
	
