extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var speed = 10
var enemiesInRange = []

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
const JUMP_FORCE = 325
const SLOW_FALL	 = 25
const MAX_FALL = 25

# Called when the node enters the scene tree for the first time.
func _ready():
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
	if Input.is_action_just_pressed("ui_accept"):
		attack()
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		velocity.x = 0
		
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	collision = move_and_collide(velocity)

func flipSprite(flipped):
	$AnimatedSprite.flip_h = flipped
	if $AnimatedSprite.flip_h == false:
		$AnimatedSprite.position = Vector2(0, 0)
		$"Attack Area".position = Vector2(6, 2)		
	if $AnimatedSprite.flip_h == true:
		$AnimatedSprite.position = Vector2(-7.5, 0)
		$"Attack Area".position = Vector2(-7, 2)

func attack():
	$AnimatedSprite.set_animation("Attack")
	isAttacking = true
	
	for enemy in enemiesInRange:
		enemy.call_deferred("damage")

func isOnGround():
	if collision == null:
		return false
		
	if $"FSM Controller".curState == $"FSM Controller/fall":
		var isNotCollidingOnSide = collision.normal != RIGHT and collision.normal != LEFT
		return collision.get_normal() != -UP and isNotCollidingOnSide
	
	return collision.get_normal() != -UP

func _on_AnimatedSprite_animation_finished():
	if isAttacking:
		isAttacking = false
		$"FSM Controller".curState.enter(self)

func _on_Attack_Area_body_entered(body):
	if body.is_in_group("enemy"):
		enemiesInRange.append(body)

func _on_Attack_Area_body_exited(body):
	if body in enemiesInRange:
		enemiesInRange.remove(body)
