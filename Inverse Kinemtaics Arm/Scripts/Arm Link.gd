extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armLength:int

# Called when the node enters the scene tree for the first time.
func _ready():
	print(tan(0))
	armLength = $"Pointer End".position.length()
#	print(armLength)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
