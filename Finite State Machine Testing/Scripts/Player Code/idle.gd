extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isRunning = false
var isJumping = false

# Called when the parent enters the state
func enter(scriptParent):
	parent.get_node("AnimatedSprite").set_animation("idle") 
	parent.velocity = Vector2(0,0)

# Called every physics frame. 'delta' is the elapsed time since the previous frame. Run in FSM _physics_process.
func inPhysicsProcess(delta):
#	if Input.is_action_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
#		isRunning = true
	pass

func changeParentState():
	if abs(parent.velocity.x) > 0:
		return states.run
	if isJumping:
		isJumping = false
		return states.jump
	if !parent.isOnGround():
		return states.fall
	return null

func handleInput(event):
	if event.is_action_pressed("ui_up"):
		isJumping = true
