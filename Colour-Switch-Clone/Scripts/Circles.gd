extends Node2D

onready var global = $"/root/Global"
 
export var rot_speed = 75

var influenced = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotate(deg2rad(rot_speed * delta))

# Collision response stuff
func collision_result(colour):
	global.colliding = true
	global.colour = colour

func _on_Cyan_body_entered(body):
	collision_result("Cyan")

func _on_Yellow_body_entered(body):
	collision_result("Yellow")

func _on_Magenta_body_entered(body):
	collision_result("Magenta")

func _on_Purple_body_entered(body):
	collision_result("Purple")

func _on_VisibilityNotifier2D_screen_entered():
	if influenced == false:
		global.spawnable = true
		influenced = true
	
	$SelfDestruct.stop()
	$SelfDestruct.wait_time = 5

func _on_VisibilityNotifier2D_screen_exited():
	# Self Destruct Timer Stuff
	$SelfDestruct.start()

func _on_SelfDestruct_timeout():
	queue_free()
