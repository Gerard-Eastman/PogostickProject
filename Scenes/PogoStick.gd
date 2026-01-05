extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	rotation_degrees += (get_rotate_input()*delta*100)
	global_position
	$PogoBody.rotation_degrees = 0
	
func get_rotate_input():
	var angleDirection = Input.get_action_strength("rotate_clockwise") -Input.get_action_strength("rotate_counterclockwise")
	return angleDirection
