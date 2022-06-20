extends Node
class_name FSMController 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parent = get_parent()
var states = {}
var curState = null setget setState
var prevState = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setState(newState):
	prevState = curState
	curState = newState
	
	if newState != null:
		swapState(curState, prevState) # goes into the new state

func addState(newState, stateFunction):
	states[newState] = stateFunction

# use to control logic when transitioning between states (useful for animation)
func swapState(newState, oldState):
	pass

# returns the state to change too
func controlStates(delta):
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if curState != null:
		get_parent().call(curState) #  runs the state code as long as the state isn't null
	
	var newState = controlStates(delta)
	if newState != null:
		setState(newState)
