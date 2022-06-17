extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armLength:int
var diff:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(tan(0))
	armLength = $"Pointer End".position.length()
	diff = $"Pointer End".global_position - position
#	print(armLength)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#diff = $"Pointer End".global_position - position
	pass
