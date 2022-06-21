extends FSMController


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isJumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	addState("idle", "idle")
	addState("run", "run")
	addState("attack", "attack")
	addState("fall", "fall")
	addState("slowFall", "slowFall")
	addState("jump", "jump")
	setState(states.jump)
	pass # Replace with function body.

func _input(event):
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		parent.velocity.x = 0
	if event.is_action_pressed("ui_up") and parent.isOnGround():
		isJumping = true
	if isJumping and event.is_action_released("ui_up"):
		isJumping = false


# returns the state to change too
func controlStates(delta):
	match(curState):
		states.jump:
			setState(states.slowFall)
		states.slowFall:
			if !isJumping:
				setState(states.fall)
		_:
			print("error")

# Called every frame. 'delta' is the elapsed time since the previous frame.
