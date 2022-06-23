extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var speed = 10

var isAttacking = false
var isJumping = false
var isIdling = true

var velocity = Vector2()
var collision:KinematicCollision2D setget , getCollision

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const UP = Vector2(0, -1)
const MAX_SPEED = 1
const GRAVITY = 5
const HORZ_ACC = 1
const JUMP_FORCE = 20
const SLOW_FALL	 = 1
const MAX_FALL = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	print(isOnGround())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print(isOnGround())

func getCollision():
	return collision

func _physics_process(delta):
	if isOnGround():
		if Input.is_action_pressed("ui_left"):
			velocity.x -= HORZ_ACC
			flipSprite(true)
		if Input.is_action_pressed("ui_right"):
			velocity.x += HORZ_ACC
			flipSprite(false)
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		velocity.x = 0
		
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	collision = move_and_collide(velocity)

func flipSprite(flipped):
	$AnimatedSprite.flip_h = flipped
	if $AnimatedSprite.flip_h == false:
		$AnimatedSprite.position = Vector2(0, 0)
	if $AnimatedSprite.flip_h == true:
		$AnimatedSprite.position = Vector2(-7.5, 0)	

func attack():
	$AnimatedSprite.set_animation("Attack")
	isAttacking = true

func jump():
	velocity.y -= JUMP_FORCE

func slowFall():
	velocity.y += SLOW_FALL
	velocity.y = clamp(velocity.y, 0, MAX_FALL)

func fall():
	velocity.y += GRAVITY
	velocity.y = clamp(velocity.y, 0, MAX_FALL)

func idle():
	velocity.y = 0
	$AnimatedSprite.set_animation("idle")

func run():
	velocity.y = 0 # for in case player just landed
	$AnimatedSprite.set_animation("Run")

func isOnGround():
	if collision == null:
		return false
		
	if $"FSM Controller".curState == $"FSM Controller/fall":
		var isNotCollidingOnSide = collision.normal != RIGHT and collision.normal != LEFT
		return collision.get_normal() != -UP and isNotCollidingOnSide
	
	return collision.get_normal() != -UP
