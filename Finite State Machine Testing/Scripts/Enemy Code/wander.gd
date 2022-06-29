extends stateObject

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var acc
var maxSpeed
var jump = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	acc = parent.HORZ_ACC
	maxSpeed = parent.MAX_SPEED
	
	var firstFlip = parent.firstFlip
	if firstFlip:
		parent.firstFlip = false
		if parent.isFlipped:
			parent.scale.x = -parent.scale.x

func exit():
	parent.velocity = Vector2(0,0)

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	if parent.isFlipped:
		parent.velocity.x += acc
		parent.velocity.x = clamp(parent.velocity.x, 0, maxSpeed)
	else:
		parent.velocity.x -= acc
		parent.velocity.x = clamp(parent.velocity.x, -maxSpeed, 0)
	
	var collisionInfo = parent.getCollision()
	if collisionInfo != null:
		if collisionInfo.normal == RIGHT:
			parent.setFlipped(true)
			jump = true
		elif collisionInfo.normal == LEFT:
			jump = true
			parent.setFlipped(false)

# Called every frame. 'delta' is the elapsed time since the previous frame. Run in FSM _process.
func inProcess(delta):
	pass

func changeParentState():
	if parent.is_on_floor(): # use ray cast to determine if object should fall instead of is_on_floor()
		print("yay")
	if parent.canAttackPlayer:
		return states.attack
	if jump:
		jump = false
		return states.jump
	return null
