extends KinematicBody2D

signal gameLost(body)

export var gravity = 9.81
export var jump = 5
export var rotateSpeed = 2


# Declare member variables here. Examples:
var velocity = Vector2()
var rot = 0
var maxTop = 10
var groundLocation
var screenSize
var birdIsAlive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size

func _input(event):
	if event.is_action_pressed("ui_select") and birdIsAlive:
		$AnimatedSprite.play('Fly')
		$Flap.play()
		velocity.y = -jump
		rot = deg2rad(-40)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += delta*gravity
	
	rot += rotateSpeed*delta
	rotation = clamp(rot, deg2rad(-40), deg2rad(90))
	
	var collisionInfo = move_and_collide(velocity)
	#print(collisionInfo)
	if collisionInfo != null:
		emit_signal("gameLost", collisionInfo.get_collider())
		$"Collision Audio".play()
		birdIsAlive = false

	position.y = clamp(position.y, maxTop, groundLocation)

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play('Idle')
