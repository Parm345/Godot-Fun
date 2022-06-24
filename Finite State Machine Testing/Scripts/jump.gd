extends stateObject

var jumpForce 
var slowFall
var isJumping = true

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	slowFall = parent.SLOW_FALL
	jumpForce = -parent.JUMP_FORCE

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
#	var collisionInfo = parent.move_and_collide(velocity)
	parent.velocity.y = jumpForce * delta
	jumpForce += slowFall
#	print(jumpForce)
	if Input.is_action_just_released("ui_up"):
		isJumping = false

func changeParentState():
	if !isJumping or jumpForce >= 0:
		isJumping = true
		return states.fall
