extends stateObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isJumping = false
var isIdling = false

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent 
	parent.get_node("AnimatedSprite").set_animation("Run")

func changeParentState():
	if isJumping:
		isJumping = false
		return states.jump
	if isIdling:
		isIdling = false
		return states.idle
	if !parent.isOnGround():
		return states.fall
	return null

func inPhysicsProcess(delta):
	pass

func handleInput(event):
	if event.is_action_pressed("ui_up"):
		isJumping = true
	if event.is_action_released("ui_right") or event.is_action_released("ui_left"):
		isIdling = true
