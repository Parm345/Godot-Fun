extends Node
class_name FSM

onready var parent = get_parent()
var states = {}
var curState = null setget setState
var prevState = null

func _ready():
	for child in get_children():
		states[child.name] = child
	inReady()

func inReady():
	pass

func setState(newState):
#	print(newState)
	
	prevState = curState
	curState = newState
	
	if prevState != null:
		prevState.exit()
	curState.enter(parent)

func _physics_process(delta):
	if curState != null:
		curState.inPhysicsProcess(delta)
		var newState = curState.changeParentState()
		if newState != null:
			setState(newState)

func _process(delta):
	if curState != null:
		curState.inProcess(delta)

func _input(event):
	if curState != null:
		curState.handleInput(event)
