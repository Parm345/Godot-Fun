extends FSMController


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	addState("idle", "idle")
	addState("run", "run")
	addState("attack", "attack")
	addState("fall", "fall")
	addState("slowFall", "slowFall")
	addState("jump", "jump")
	setState(states.idle)
	pass # Replace with function body.

func _input(event):
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		parent.velocity.x = 0
		parent.isIdling = true
		parent.isRunning = false
	if event.is_action_pressed("ui_up") and parent.isOnGround():
		parent.isJumping = true
	if parent.isJumping and event.is_action_released("ui_up"):
		parent.isJumping = false


# returns the state to change too
func controlStates(delta):
	match(curState):
		states.idle:
			if parent.isRunning:
				return states.run
			if parent.isAttacking:
				return states.attack
			if parent.isJumping:
				return states.jump
		states.run:
			if parent.isIdling:
				return states.idle
			if parent.isJumping:
				return states.jump
			if parent.isAttacking:
				return states.attack
		states.attack:
			if !parent.isAttacking:
				if parent.isIdling:
					return states.idle
				if parent.isJumping:
					return states.jump
				if parent.isRunning:
					return states.run
		states.jump:
			return states.slowFall
		states.slowFall:
			if !parent.isJumping:
				return states.fall
		states.fall:
			if parent.isOnGround():
				return states.idle
		_:
			print("error")
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
