extends stateObject

var jumpForce 
var isJumping = true

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	jumpForce = -parent.JUMP_FORCE
	parent.velocity.y = jumpForce

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
#	var collisionInfo = parent.move_and_collide(velocity)
	if Input.is_action_just_released("ui_up"):
		isJumping = false

func changeParentState():
	if !isJumping:
		return states.fall
