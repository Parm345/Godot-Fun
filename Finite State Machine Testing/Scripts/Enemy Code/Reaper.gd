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

var groundLevel setget setGroundLevel
var jumpTargetPos: Vector2 = Vector2() setget setJumpTargetPos, getJumpTargetPos
var collision: KinematicCollision2D setget , getCollision
var isFlipped = false setget setFlipped

# Setters and Getters

func setGroundLevel(setNewGroundLevel: bool = true):
	if setNewGroundLevel:
		groundLevel = $"Ground Pointer".get_collision_point().y

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

# Generic Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	velocity.y += GRAVITY * delta # apply gravity
	velocity = move_and_slide(velocity, UP)
	collision = get_last_slide_collision()
#	print($FSM.curState)
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		print("Collided with: ", collision.collider.name)

#	print(collision)
	#print(is_on_floor(), is_on_ceiling())
# Condition Checkers

func playerOnTop():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player" and collision.normal == UP:
			return true
	return false

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
