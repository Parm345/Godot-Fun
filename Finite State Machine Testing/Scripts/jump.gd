extends stateObject

var jumpForce 
var velocity: Vector2 

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	jumpForce = -parent.JUMP_FORCE
	velocity = parent.velocity
	velocity.y = jumpForce

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	var collisionInfo = parent.move_and_collide(velocity)

func changeParentState():
	return states.fall
