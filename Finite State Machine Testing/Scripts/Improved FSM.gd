extends Node
class_name FSM

onready var parent = get_parent()
var states = {}
var curState = null setget setState
var prevState = null

func _ready():
	for child in get_children():
		states[child.name] = child

func setState(newState):
	prevState = curState
	curState = newState
	curState.enter(parent)

func handleInput(event):
	pass

func _physics_process(delta):
	curState.inPhysicsProcess()
	var newState = curState.changeParentState()
	if newState != null:
		setState(newState)
