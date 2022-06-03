extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var forceStrength = 100
export (int) var momentStrength = 5000

var screenSize
var thrust = Vector2()
var rotationDir = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().get_visible_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		thrust = Vector2(0, -forceStrength)
	else:
		thrust = Vector2()
	
	rotationDir = 0
	if Input.is_action_pressed("ui_right"):
		rotationDir += 1
	if Input.is_action_pressed("ui_left"):
		rotationDir += -1
		
#	print(thrust)

func _integrate_forces(state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotationDir*momentStrength)
	
	var xform = state.get_transform()
	if xform.origin.x > screenSize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screenSize.x
	if xform.origin.y > screenSize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screenSize.y
	
	state.set_transform(xform)
	

