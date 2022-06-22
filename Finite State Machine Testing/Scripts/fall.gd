extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity
var maxFall
var velocity:Vector2
var collisionInfo: KinematicCollision2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	gravity = parent.GRAVITY
	maxFall = parent.MAX_FALL
	velocity = parent.velocity

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	velocity.y += gravity
	velocity.y = clamp(velocity.y, 0, maxFall)
	collisionInfo = parent.move_and_collide(velocity)

func changeParentState():
	if parent.isOnGround():
		return states.idle
	return null

