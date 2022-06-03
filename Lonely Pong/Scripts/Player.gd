extends StaticBody2D

export var speed = 5

var velocity = Vector2()
var screensize

func _ready():
	screensize = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_key_pressed(87):
		velocity.y -= 1
	if Input.is_key_pressed(83):
		velocity.y += 1
	
	var maxScreenSize = screensize.y - ($CollisionShape2D.scale.y  * 10)
	var minScreenSize = $CollisionShape2D.scale.y * 10
	
	position += velocity*speed
	position.y = clamp(position.y, minScreenSize, maxScreenSize)

	
#func _physics_process(delta):
	#var collision = move_and_collide(velocity*delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
