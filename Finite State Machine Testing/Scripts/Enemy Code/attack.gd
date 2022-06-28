extends stateObject

var isAttacking: bool

# Called when the parent enters the state
func enter(scriptParent):
	parent = scriptParent
	parent.get_node("AnimatedSprite").set_animation("Attack") 
	parent.get_node("AnimatedSprite").position = Vector2(-2, -4)
	isAttacking = true

# Called when parent leaves the state, most likely not necessary 
func exit():
	parent.get_node("AnimatedSprite").position = Vector2(0,0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame. Run in FSM _process.
func inProcess(delta):
	pass

func changeParentState():
	if !isAttacking:
		return states.idle
	return null

func _on_AnimatedSprite_animation_finished():
	isAttacking = false
