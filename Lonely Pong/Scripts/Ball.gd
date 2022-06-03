extends KinematicBody2D

signal hit
signal game_over

export var speed = 10

var velocity = Vector2()

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		emit_signal("hit")
		velocity = velocity.bounce(collision.normal)
		
func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("game_over")
	velocity.x = 0
	velocity.y = 0
	
func _ready():
	hide()

func _process(delta):
	position += velocity * speed

func _on_Ball_Spawn_timeout():
	show()
	
	velocity.x -= 1
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randnum = rng.randi_range(2,1)
	
	if randnum == 1:
		velocity.y += 1
	elif randnum == 2:
		velocity.y -= 1
