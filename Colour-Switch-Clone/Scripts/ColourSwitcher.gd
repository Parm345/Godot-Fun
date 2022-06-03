extends Area2D

onready var global = $"/root/Global"

var influenced = false

func _on_ColourSwitcher_body_entered(body):
	global.change_colour = true
	queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	if influenced == false:
		global.spawnable = true
		influenced = true
	
	# Self Destruct Timer stuff
	$SelfDestruct.stop()
	$SelfDestruct.wait_time = 5

# Self Destruct Timer Stuff
func _on_VisibilityNotifier2D_screen_exited():
	$SelfDestruct.start()

func _on_SelfDestruct_timeout():
	queue_free()
