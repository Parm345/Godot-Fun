extends KinematicBody2D


const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const UP = Vector2(0, -1)
const MAX_SPEED = 10
const GRAVITY = 200
const HORZ_ACC = 1
const JUMP_FORCE = 3000
const SLOW_FALL = 50
const MAX_FALL = 1000

var velocity: Vector2 = Vector2()
var bodiesInAttackRange = []
var canAttackPlayer = false
var firstFlip = true

var lastSeenPlayerPos: Vector2 = Vector2() setget , getLastSeenPlayerPos
var jumpTargetPos: Vector2 = Vector2() setget setJumpTargetPos, getJumpTargetPos
var collision: KinematicCollision2D setget , getCollision
var isFlipped = false setget setFlipped

# Setters and Getters

func getLastSeenPlayerPos():
	return lastSeenPlayerPos

func getJumpTargetPos():
	return jumpTargetPos

func setJumpTargetPos(target: Vector2):
	jumpTargetPos = target

func getCollision():
	return collision

# does not work properly if _isFlipped == false in _ready
func setFlipped(_isFlipped: bool):
	isFlipped = _isFlipped
	scale.x = -scale.x

# Flow Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(position, " ", lastSeenPlayerPos)
	pass

func _physics_process(delta):
	velocity.y += GRAVITY * delta # apply gravity
	velocity = move_and_slide(velocity, UP)
	collision = get_last_slide_collision()

	
# Condition Checkers/Control

func canJump():
	if $"Jump Sightline".is_colliding():
		return false
	return true

func changeColour(newColour: Color):
	set_modulate(newColour)

func playerSeen():
	if $"Player Sightline".is_colliding():
		if $"Player Sightline".get_collider().name == "Player":
			lastSeenPlayerPos = $"Player Sightline".get_collision_point()
#			print(lastSeenPlayerPos, get_parent().get_node("Player").global_position, position)
			return true
	return false

func playerSeenAt():
	return $"Player Sightline".get_collision_point()

func flip():
	setFlipped(!isFlipped)

# Signal Control

func _on_Attack_Area_body_entered(body):
	if body.has_method("hurt"):
		bodiesInAttackRange.append(body)
		if body.name == "Player":
			canAttackPlayer = true

func _on_Attack_Area_body_exited(body):
	if body in bodiesInAttackRange:
		bodiesInAttackRange.erase(body)
		if body.name == "Player":
			canAttackPlayer = false
