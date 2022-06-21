extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var speed = 10

var isAttacking = false

var velocity = Vector2()
var collision:KinematicCollision2D setget ,getCollision 

const MAX_SPEED = 10
const GRAVITY = -5
const HORZ_ACC = 2
const JUMP_FORCE = 5
const SLOW_FALL	 = 1
const MAX_FALL = 25

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
	if Input.is_action_pressed("ui_left"):
		velocity.x -= HORZ_ACC
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		velocity.x += HORZ_ACC
		$AnimatedSprite.flip_h = false
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	collision = move_and_collide(velocity)

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
#		print("yo")
		return false
	return collision.position.y > position.y
