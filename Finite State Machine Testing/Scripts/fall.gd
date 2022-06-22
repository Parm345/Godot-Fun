extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	parent.velocity.y += gravity
	parent.velocity.y = clamp(parent.velocity.y, 0, maxFall)
	collisionInfo = parent.getCollision()
	if collisionInfo == null:
		allowLeft = true
		allowRight = true
	else:
		parent.velocity.x = 0
		if collisionInfo.position.x > parent.position.x:
			allowRight = false
		elif collisionInfo.position.x < parent.position.y:
			allowLeft = false
	
	if Input.is_action_pressed("ui_left") && allowLeft:
			parent.velocity.x -= parent.HORZ_ACC
			parent.get_node("AnimatedSprite").flip_h = true
	if Input.is_action_pressed("ui_right") && allowRight:
			parent.velocity.x += parent.HORZ_ACC
			parent.get_node("AnimatedSprite").flip_h = false
#	parent.setCollision(collisionInfo)

func changeParentState():
	if parent.isOnGround():
		print("is on ground")
		return states.idle
	return null

