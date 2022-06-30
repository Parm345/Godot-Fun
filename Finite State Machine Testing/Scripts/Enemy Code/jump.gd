extends stateObject

var gravity
var slowFall
var jumpForce
var jumpTo: Vector2

func enter(scriptParent):
	parent = scriptParent
	gravity = parent.GRAVITY
	slowFall = parent.SLOW_FALL
	jumpForce = -parent.JUMP_FORCE
	jumpTo = parent.getJumpTargetPos()

	
func inPhysicsProcess(delta):
#	var collisionInfo = parent.move_and_collide(velocity)
	if parent.isFlipped:
		parent.velocity.x = parent.MAX_SPEED
	else:
		parent.velocity.x = -parent.MAX_SPEED
	parent.velocity.y = jumpForce * delta
	jumpForce += slowFall

func changeParentState():
	if jumpForce >= 0:
		return states.fall
	return null
