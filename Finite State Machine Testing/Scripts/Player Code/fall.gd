extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var gravity
var maxFall
var collisionInfo: KinematicCollision2D

var allowLeft = true
var allowRight = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	gravity = parent.GRAVITY
	maxFall = parent.MAX_FALL

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
	parent.velocity.y += gravity*delta
	parent.velocity.y = clamp(parent.velocity.y, 0, maxFall)
	collisionInfo = parent.getCollision()
	if collisionInfo == null:
		allowLeft = true
		allowRight = true
	else:
		parent.velocity.x = 0
		if collisionInfo.get_normal() == LEFT:
			allowRight = false
#			print("no")
		elif collisionInfo.get_normal() == RIGHT:
			allowLeft = false
#			print("no 2")
	
	if Input.is_action_pressed("ui_left") && allowLeft:
			parent.velocity.x -= parent.HORZ_ACC
			parent.flipSprite(true)
	if Input.is_action_pressed("ui_right") && allowRight:
			parent.velocity.x += parent.HORZ_ACC
			parent.flipSprite(false)
#	parent.setCollision(collisionInfo)

func changeParentState():
	if parent.isOnGround():
#		print("is on ground")
		return states.idle
	return null

