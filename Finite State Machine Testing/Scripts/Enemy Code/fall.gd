extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var gravity
var maxFall
var collisionInfo: KinematicCollision2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	gravity = parent.GRAVITY
	maxFall = parent.MAX_FALL
	if parent.isFlipped:
		parent.velocity.x = parent.MAX_SPEED
	else:
		parent.velocity.x = -parent.MAX_SPEED

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	#parent.velocity.y += gravity*delta
	#parent.velocity.y = clamp(parent.velocity.y, 0, maxFall)
#	print(parent.velocity)
	pass
func changeParentState():
	if parent.is_on_floor():
		return states.idle
	return null

