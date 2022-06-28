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

func changeParentState():
	return states.wander
