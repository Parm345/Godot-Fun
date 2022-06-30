extends stateObject

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var knownPlayerPos = Vector2(0,0)
var playerFound
var acc
var maxSpeed
var jump = false

var lookedOpposite = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	parent.changeColour(Color.crimson) 
	playerFound = true
	
	acc = parent.HORZ_ACC * 3
	maxSpeed = parent.MAX_SPEED * 3
	knownPlayerPos = parent.lastSeenPlayerPos
	
	var firstFlip = parent.firstFlip
	if firstFlip:
		parent.firstFlip = false
		if parent.isFlipped:
			parent.scale.x = -parent.scale.x

# Called when parent leaves the state, most likely not necessary 
func exit():
	parent.changeColour(Color.white)

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	if parent.playerSeen():
		acc = parent.HORZ_ACC * 3		
		knownPlayerPos = parent.getLastSeenPlayerPos()
	
	if parent.isFlipped:
		parent.velocity.x += acc
		parent.velocity.x = clamp(parent.velocity.x, 0, maxSpeed)
	else:
		parent.velocity.x -= acc
		parent.velocity.x = clamp(parent.velocity.x, -maxSpeed, 0)
	
	var collisionInfo = parent.getCollision()
	if collisionInfo != null:
		if collisionInfo.normal == RIGHT:
			if parent.canJump():
				jump = true
			else:
				parent.setFlipped(true)
		elif collisionInfo.normal == LEFT:
			if parent.canJump():
				jump = true
			else:
				parent.setFlipped(false)
	
	if abs(parent.position.x - knownPlayerPos.x) <= 5 and int(parent.position.y) == int(knownPlayerPos.y):
		parent.velocity = Vector2(0,0)
		if $"search timer".time_left == 0:
			$"search timer".start()
			acc = 0
			

# Called every frame. 'delta' is the elapsed time since the previous frame. Run in FSM _process.
func inProcess(delta):
	pass

func changeParentState():
	if parent.canAttackPlayer:
		return states.attack
	if jump and parent.is_on_floor():
		jump = false
		return states.jump
	if !playerFound:
		playerFound = true
		return states.idle
	return null

func _on_search_timer_timeout():
	if !lookedOpposite:
		parent.flip()
		lookedOpposite = true
		$"search timer".start()
	elif !parent.playerSeen():
		parent.flip()
		lookedOpposite = false
		playerFound = false
		knownPlayerPos = Vector2(0,0)
		

func _on_give_up_timer_timeout():
	playerFound = false
