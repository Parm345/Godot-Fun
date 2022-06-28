extends KinematicBody2D


const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const UP = Vector2(0, -1)
const MAX_SPEED = 10
const GRAVITY = 200
const HORZ_ACC = 1
const JUMP_FORCE = 325
const MAX_FALL = 1000

var bodiesInAttackRange = []
var collision: KinematicCollision2D setget , getCollision
var velocity: Vector2 = Vector2()
var isFlipped = false setget setFlipped
var canAttackPlayer = false
var firstFlip = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(get_scale().x)
	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity, UP)
	collision = get_last_slide_collision()
	
func getCollision():
	return collision

# does not work properly if _isFlipped == false in _ready
func setFlipped(_isFlipped):
	isFlipped = _isFlipped
	scale.x = -scale.x

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
